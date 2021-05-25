Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81059C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626B761417
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 12:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhEYMFp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhEYMFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 08:05:43 -0400
X-Greylist: delayed 180 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 May 2021 05:04:12 PDT
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C95C061574;
        Tue, 25 May 2021 05:04:12 -0700 (PDT)
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id DC3DA2E1AA4;
        Tue, 25 May 2021 15:01:05 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id JpeZ6PSFUr-151GRSB9;
        Tue, 25 May 2021 15:01:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1621944065; bh=aigr+WKrVt1ocq4yhrHl8FrUviBzCQg0datyEmAK6MU=;
        h=In-Reply-To:References:Date:Message-ID:From:To:Subject:Cc;
        b=05DzBrnCTJBST4u8yJtJY14DfmAjCewlI0oVUs8k2OlddnnIWo+7568w7sJmdeJQx
         oXH2MFq1s0dNZHQh8u3TLbs8L5cywUr7hYA/LXGaz/W3o2551FPJRZHclH09uY0kGc
         XrtWY3voIPVjZh2Y4riTco9taio0npFVdBqjZyKE=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:7209::1:15])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id pDtZrO7kJP-15oWwC24;
        Tue, 25 May 2021 15:01:05 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210520133908.98891-1-damtev@yandex-team.ru>
 <20210520133908.98891-2-damtev@yandex-team.ru>
 <YKu4Qovv1KMplifY@stefanha-x1.localdomain>
 <90021621883891@mail.yandex-team.ru>
 <21b08ea7-71c6-1b4b-3833-1c51d0e1d310@redhat.com>
From:   Iurii Kamenev <damtev@yandex-team.ru>
Message-ID: <d7665bc7-1806-ba88-9d7d-0c1352df43d3@yandex-team.ru>
Date:   Tue, 25 May 2021 15:00:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <21b08ea7-71c6-1b4b-3833-1c51d0e1d310@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for your remark. I guess it is possible, I will try to rewrite it 
that way.

24.05.2021 22:41, Paolo Bonzini пишет:
> On 24/05/21 21:34, Юрий Каменев wrote:
>> Hi
>>
>>     Is your goal to avoid accidentally detecting partitions because it's
>>     confusing when that happens?
>>
>> The main goal is reducing the kernel start time. It might be use 
>> useful in tiny systems that use, for example, squashfs images with 
>> certainly no partitions. Disabling partitions scanning for these 
>> images can save a few tens of milliseconds which can be a significant 
>> acceleration for starting such systems.
>
> Perhaps that could be configured in the image, for example in the 
> kernel command line?
>
> Paolo
>
>> 24.05.2021, 17:29, "Stefan Hajnoczi" <stefanha@redhat.com>:
>>
>>     On Thu, May 20, 2021 at 04:39:08PM +0300, Yury Kamenev wrote:
>>
>>     Hi,
>>     Is there a VIRTIO spec change for the new VIRTIO_BLK_F_NO_PS feature
>>     bit? Please send one:
>> https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback
>> <https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback>
>>
>>     GENHD_FL_NO_PART_SCAN is not used much in other drivers. This 
>> makes me
>>     wonder if the same use case is addressed through other means with 
>> SCSI,
>>     NVMe, etc devices. Maybe Christoph or Jens can weigh in on whether
>>     adding a bit to disable partition scanning for a virtio-blk fits 
>> into
>>     the big picture?
>>
>>     Is your goal to avoid accidentally detecting partitions because it's
>>     confusing when that happens?
>>
>>     VIRTIO is currently undergoing auditing and changes to support 
>> untrusted
>>     devices. From that perspective adding a device feature bit to 
>> disable
>>     partition scanning does not help protect the guest from an untrusted
>>     disk. The guest cannot trust the device, instead the guest itself 
>> would
>>     need to be configured to avoid partition scanning of untrusted 
>> devices.
>>
>>     Stefan
>>
>>           Signed-off-by: Yury Kamenev <damtev@yandex-team.ru
>>         <mailto:damtev@yandex-team.ru>>
>>           ---
>>            drivers/block/virtio_blk.c | 6 ++++++
>>            include/uapi/linux/virtio_blk.h | 1 +
>>            2 files changed, 7 insertions(+)
>>
>>           diff --git a/drivers/block/virtio_blk.c
>>         b/drivers/block/virtio_blk.c
>>           index b9fa3ef5b57c..17edcfee2208 100644
>>           --- a/drivers/block/virtio_blk.c
>>           +++ b/drivers/block/virtio_blk.c
>>           @@ -799,6 +799,10 @@ static int virtblk_probe(struct
>>         virtio_device *vdev)
>>                    vblk->disk->flags |= GENHD_FL_EXT_DEVT;
>>                    vblk->index = index;
>>
>>           + /*Disable partitions scanning for no-partitions block*/
>>
>>
>>     Formatting cleanup and rephrasing:
>>
>>        /* Disable partition scanning for devices with no partitions */
>>
>>           + if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PS))
>>
>>
>>     I suggest user a more obvious name:
>>
>>        VIRTIO_BLK_F_NO_PART_SCAN
>>
>>           + vblk->disk->flags |= GENHD_FL_NO_PART_SCAN;
>>           +
>>                    /* configure queue flush support */
>>                    virtblk_update_cache_mode(vdev);
>>
>>           @@ -977,6 +981,7 @@ static unsigned int features_legacy[] = {
>>                    VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>>                    VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
>>         VIRTIO_BLK_F_CONFIG_WCE,
>>                    VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
>>         VIRTIO_BLK_F_WRITE_ZEROES,
>>           + VIRTIO_BLK_F_NO_PS,
>>            }
>>            ;
>>            static unsigned int features[] = {
>>           @@ -984,6 +989,7 @@ static unsigned int features[] = {
>>                    VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>>                    VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
>>         VIRTIO_BLK_F_CONFIG_WCE,
>>                    VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
>>         VIRTIO_BLK_F_WRITE_ZEROES,
>>           + VIRTIO_BLK_F_NO_PS,
>>            };
>>
>>            static struct virtio_driver virtio_blk = {
>>           diff --git a/include/uapi/linux/virtio_blk.h
>>         b/include/uapi/linux/virtio_blk.h
>>           index d888f013d9ff..f197d07afb05 100644
>>           --- a/include/uapi/linux/virtio_blk.h
>>           +++ b/include/uapi/linux/virtio_blk.h
>>           @@ -40,6 +40,7 @@
>>            #define VIRTIO_BLK_F_MQ 12 /* support more than one vq */
>>            #define VIRTIO_BLK_F_DISCARD 13 /* DISCARD is supported */
>>            #define VIRTIO_BLK_F_WRITE_ZEROES 14 /* WRITE ZEROES is
>>         supported */
>>           +#define VIRTIO_BLK_F_NO_PS 16 /* No partitions */
>>
>>            /* Legacy feature bits */
>>            #ifndef VIRTIO_BLK_NO_LEGACY
>>           --
>>           2.24.3 (Apple Git-128)
>>
>
