Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D46C43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 11:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355010AbiFVLOM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 07:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354748AbiFVLOL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 07:14:11 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980CA2F64A
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 04:14:10 -0700 (PDT)
Subject: Re: [RFC PATCH 1/6] rnbd-clt: open code send_msg_open in
 rnbd_clt_map_device
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655896448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HIaFmUqaBXhb4Lr35uZp5JoV1Upx+YHXO4feMwtWpg=;
        b=DKFeq0vS6CyL31eqESySZbJFZUBk1fzeKt92RNIu0psTpBXcIDnGe6uhsPopenyvwi/dgq
        ZfMu9vEEPBgVk08xFtGF6ji979joGVYpxBW6HH9nO3oIE4I9bzX50Wz+HSqEI9gNV82gD6
        PzgxBSyJeVK8uHJBrlECBf91dhHFuuM=
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
References: <20220620034923.35633-1-guoqing.jiang@linux.dev>
 <20220620034923.35633-2-guoqing.jiang@linux.dev>
 <CAMGffEn9_FPgX_RLds7RwPL_TSft0NHFXTsR_AjyeQF=mXQwkA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <85061957-e116-1f3a-ecba-8e3d4770c94c@linux.dev>
Date:   Wed, 22 Jun 2022 19:14:05 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffEn9_FPgX_RLds7RwPL_TSft0NHFXTsR_AjyeQF=mXQwkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/21/22 11:11 PM, Jinpu Wang wrote:
> On Mon, Jun 20, 2022 at 5:49 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> Let's open code it in rnbd_clt_map_device, then we can use information
>> from rsp to setup gendisk and request_queue in next commits. After that,
>> we can remove some members (wc, fua and max_hw_sectors etc) from struct
>> rnbd_clt_dev.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/block/rnbd/rnbd-clt.c | 44 +++++++++++++++++++++++++++++++++--
>>   1 file changed, 42 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
>> index 409c76b81aed..0396532da742 100644
>> --- a/drivers/block/rnbd/rnbd-clt.c
>> +++ b/drivers/block/rnbd/rnbd-clt.c
>> @@ -1562,7 +1562,14 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>>   {
>>          struct rnbd_clt_session *sess;
>>          struct rnbd_clt_dev *dev;
>> -       int ret;
>> +       int ret, errno;
>> +       struct rnbd_msg_open_rsp *rsp;
>> +       struct rnbd_msg_open msg;
>> +       struct rnbd_iu *iu;
>> +       struct kvec vec = {
>> +               .iov_base = &msg,
>> +               .iov_len  = sizeof(msg)
>> +       };
>>
>>          if (exists_devpath(pathname, sessname))
>>                  return ERR_PTR(-EEXIST);
>> @@ -1582,13 +1589,46 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>>                  ret = -EEXIST;
>>                  goto put_dev;
>>          }
>> -       ret = send_msg_open(dev, RTRS_PERMIT_WAIT);
>> +
>> +       rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
>> +       if (!rsp) {
>> +               ret = -ENOMEM;
>> +               goto del_dev;
>> +       }
>> +
>> +       iu = rnbd_get_iu(sess, RTRS_ADMIN_CON, RTRS_PERMIT_WAIT);
>> +       if (!iu) {
>> +               ret = -ENOMEM;
>> +               kfree(rsp);
>> +               goto del_dev;
>> +       }
>> +       iu->buf = rsp;
>> +       iu->dev = dev;
>> +       sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
>> +
>> +       msg.hdr.type    = cpu_to_le16(RNBD_MSG_OPEN);
>> +       msg.access_mode = dev->access_mode;
>> +       strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
>> +
>> +       WARN_ON(!rnbd_clt_get_dev(dev));
>> +       ret = send_usr_msg(sess->rtrs, READ, iu,
>> +                          &vec, sizeof(*rsp), iu->sgt.sgl, 1,
>> +                          msg_open_conf, &errno, RTRS_PERMIT_WAIT);
>> +       if (ret) {
>> +               rnbd_clt_put_dev(dev);
>> +               rnbd_put_iu(sess, iu);
>> +               kfree(rsp);
>> +       } else {
>> +               ret = errno;
>> +       }
>> +       rnbd_put_iu(sess, iu);
>>          if (ret) {
>>                  rnbd_clt_err(dev,
>>                                "map_device: failed, can't open remote device, err: %d\n",
>>                                ret);
>>                  goto del_dev;
>>          }
>> +
> looks ok, except this new line seems not needed.

Will remove it in next version.

Thanks,
Guoqing
