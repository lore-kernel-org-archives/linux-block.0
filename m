Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA8C4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 21:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4E821871
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 21:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570570186;
	bh=f7XVbDLpFmAD4Xl0xpwWSVizeSVRTOEy+b9x6pPH9Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cqkZtZpEXvhHM1A/Up+AaWBC9QRV2DZK9RNhQQq0wq8HHz01pcqriCCo7bM39lOL8
	 3eV+e0nX0IqTAiw2DoEbJV2YkNexAwTa9zukMO4ipM/ZIwg3FIg3EXC4IpDONH/kXX
	 nl6exMPhLmnHKd9OtOH1MO+MWYx543qfYIlcrnmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfJHV3q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbfJHV3q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Oct 2019 17:29:46 -0400
Received: from localhost (unknown [131.107.159.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D4CD21721;
        Tue,  8 Oct 2019 21:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570570184;
        bh=f7XVbDLpFmAD4Xl0xpwWSVizeSVRTOEy+b9x6pPH9Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KU55GiyhZD7rQCwbWg+1nx4bIlXF2vwAO3K23T8wnZyMeK4k6EsyGRdoXJXaRZPZg
         IuQMXIyo/UK2UQN5K2T8RBoJ3efYWHeIJXbxAA6HqeNWCUHlnyPRvtZRajAI21oT12
         2NvZG+fPPpQJcKxGatoGHZcpY9TYw/edOTUZ7AuQ=
Date:   Tue, 8 Oct 2019 17:29:44 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 5.3 15/71] rbd: fix response length parameter for
 encoded strings
Message-ID: <20191008212944.GD1396@sasha-vm>
References: <20191001163922.14735-1-sashal@kernel.org>
 <20191001163922.14735-15-sashal@kernel.org>
 <CAOi1vP-2iSHxJVOabN05+NCiSZ0DxBC9fGN=5cx98mk5RvaDZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOi1vP-2iSHxJVOabN05+NCiSZ0DxBC9fGN=5cx98mk5RvaDZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 01, 2019 at 07:15:49PM +0200, Ilya Dryomov wrote:
>On Tue, Oct 1, 2019 at 6:39 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>>
>> [ Upstream commit 5435d2069503e2aa89c34a94154f4f2fa4a0c9c4 ]
>>
>> rbd_dev_image_id() allocates space for length but passes a smaller
>> value to rbd_obj_method_sync().  rbd_dev_v2_object_prefix() doesn't
>> allocate space for length.  Fix both to be consistent.
>>
>> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
>> Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/block/rbd.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index c8fb886aebd4e..69db7385c8df5 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -5669,17 +5669,20 @@ static int rbd_dev_v2_image_size(struct rbd_device *rbd_dev)
>>
>>  static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
>>  {
>> +       size_t size;
>>         void *reply_buf;
>>         int ret;
>>         void *p;
>>
>> -       reply_buf = kzalloc(RBD_OBJ_PREFIX_LEN_MAX, GFP_KERNEL);
>> +       /* Response will be an encoded string, which includes a length */
>> +       size = sizeof(__le32) + RBD_OBJ_PREFIX_LEN_MAX;
>> +       reply_buf = kzalloc(size, GFP_KERNEL);
>>         if (!reply_buf)
>>                 return -ENOMEM;
>>
>>         ret = rbd_obj_method_sync(rbd_dev, &rbd_dev->header_oid,
>>                                   &rbd_dev->header_oloc, "get_object_prefix",
>> -                                 NULL, 0, reply_buf, RBD_OBJ_PREFIX_LEN_MAX);
>> +                                 NULL, 0, reply_buf, size);
>>         dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
>>         if (ret < 0)
>>                 goto out;
>> @@ -6696,7 +6699,6 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
>>         dout("rbd id object name is %s\n", oid.name);
>>
>>         /* Response will be an encoded string, which includes a length */
>> -
>>         size = sizeof (__le32) + RBD_IMAGE_ID_LEN_MAX;
>>         response = kzalloc(size, GFP_NOIO);
>>         if (!response) {
>> @@ -6708,7 +6710,7 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
>>
>>         ret = rbd_obj_method_sync(rbd_dev, &oid, &rbd_dev->header_oloc,
>>                                   "get_id", NULL, 0,
>> -                                 response, RBD_IMAGE_ID_LEN_MAX);
>> +                                 response, size);
>>         dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
>>         if (ret == -ENOENT) {
>>                 image_id = kstrdup("", GFP_KERNEL);
>
>Hi Sasha,
>
>This patch just made things consistent, there was no bug here.  I don't
>think it should be backported.

I'll drop it, thanks!

-- 
Thanks,
Sasha
