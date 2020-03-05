Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D174FC3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 15:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C9B21556
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 15:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="Jz13duDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgCEP5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:57:03 -0500
Received: from server.eikelenboom.it ([91.121.65.215]:56748 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgCEP5C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 10:57:02 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 10:57:02 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7zaRKGsS0ZE69bPjVfBfvoMx3pCqo5nNA7n4fl7ujvw=; b=Jz13duDqLs43Wm1XWWqVFYDdVi
        uowHRKPtI85xiEhqC1CHiWIVqwu5o8osd2w3ocR/lktYKldMi/jWfzSYsehwW7zq6dHMTyWbdu9of
        OcmlvvPoZNMZ8i2Bb0effUlmmp2LE+ytNWqNMJMjKcWcOxVSE0totMaCx8pF35QZpVMA=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:54264 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <linux@eikelenboom.it>)
        id 1j9skC-0005zf-Kp; Thu, 05 Mar 2020 16:49:04 +0100
Subject: Re: [Xen-devel] [PATCH v2] xen/blkfront: fix ring info addressing
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20200305114044.20235-1-jgross@suse.com>
 <20200305124255.GW24458@Air-de-Roger.citrite.net>
 <c2c1573a-8c98-4a99-64fb-1346ee724d08@suse.com>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <68f09f4e-180f-0fb7-c329-f3f03be72eb6@eikelenboom.it>
Date:   Thu, 5 Mar 2020 16:47:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c2c1573a-8c98-4a99-64fb-1346ee724d08@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/03/2020 14:40, Jürgen Groß wrote:
> On 05.03.20 13:42, Roger Pau Monné wrote:
>> On Thu, Mar 05, 2020 at 12:40:44PM +0100, Juergen Gross wrote:
>>> Commit 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to
>>> actual use case") made struct blkfront_ring_info size dynamic. This is
>>> fine when running with only one queue, but with multiple queues the
>>> addressing of the single queues has to be adapted as the structs are
>>> allocated in an array.
>>>
>>> Fixes: 0265d6e8ddb890 ("xen/blkfront: limit allocated memory size to actual use case")
>>> Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>> V2:
>>> - get rid of rinfo_ptr() helper
>>> - use proper parenthesis in for_each_rinfo()
>>> - rename rinfo parameter of for_each_rinfo()
>>> ---
>>>   drivers/block/xen-blkfront.c | 79 +++++++++++++++++++++++---------------------
>>>   1 file changed, 42 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>>> index e2ad6bba2281..8e844da826db 100644
>>> --- a/drivers/block/xen-blkfront.c
>>> +++ b/drivers/block/xen-blkfront.c
>>> @@ -213,6 +213,7 @@ struct blkfront_info
>>>   	struct blk_mq_tag_set tag_set;
>>>   	struct blkfront_ring_info *rinfo;
>>>   	unsigned int nr_rings;
>>> +	unsigned int rinfo_size;
>>>   	/* Save uncomplete reqs and bios for migration. */
>>>   	struct list_head requests;
>>>   	struct bio_list bio_list;
>>> @@ -259,6 +260,18 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
>>>   static void blkfront_gather_backend_features(struct blkfront_info *info);
>>>   static int negotiate_mq(struct blkfront_info *info);
>>>   
>>> +#define for_each_rinfo(info, ptr, idx)				\
>>> +	for ((ptr) = (info)->rinfo, (idx) = 0;			\
>>> +	     (idx) < (info)->nr_rings;				\
>>> +	     (idx)++, (ptr) = (void *)(ptr) + (info)->rinfo_size)
>>> +
>>> +static struct blkfront_ring_info *get_rinfo(struct blkfront_info *info,
>>
>> I still think inline should be added here, but I don't have such a
>> strong opinion to block the patch on it.
> 
> I can add it if you like that better. Won't make much difference in the
> end.
> 
>> Also, info should be constified AFAICT.
> 
> Yes.
> 
>>
>> With at least info constified:
>>
>> Acked-by: Roger Pau Monné <roger.pau@citrix.com>
>>
>> Can you queue this through the Xen tree?
> 
> Sure.
> 
> 
> Juergen
> 

Just tested v2 and it works for me, thanks !

--
Sander

