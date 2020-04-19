Return-Path: <SRS0=58UM=6D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033B7C38A30
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38F821841
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 15:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDSP31 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:29:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42281 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgDSP30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Apr 2020 11:29:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id r20so3681000pfh.9;
        Sun, 19 Apr 2020 08:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vf5Ys0n4QuLYjMbMujqzndIesiC3iGVNIhkoc8BRjig=;
        b=VLh+V3eFm5Cq+4FyYZv59Pp49O19AoHtUtw/hTybo25lz+yG1gFrU9LN4N1BD9ZFVh
         lQacO5lYBMS3pvetbzlKOFwe3faKgE2nxY6N1q9zTqEYqspa6KoCoIOcVMsXt5ppwqso
         IJnNGNprM4ikySnHb/iE5v9zYu4OOaPCd+sssPIOWYiuGO1pX5BnORXKlBcWEsQR5gKN
         aM0v3Q8Rqw04UgwaabU/WykUjs5A/hqzLISHmH92zgNWAdtU3IfQ1mR8o0O+hBCtPxG1
         IGgXrRFe9zkV/GeTNRmROy8uL+3RAzhVyhGomvZsIfA40GtqGpZn2bYms7dS/UKktZ0X
         QZUw==
X-Gm-Message-State: AGi0PuZ7pHao3wFiTXoViCxJNPeFtyJHpLQI4+6lShnFh9TnzsjdPNhK
        Jws0ov82g+uB2WkNzbFtNDgmB+2sQfI=
X-Google-Smtp-Source: APiQypI/qCauFHyDdu5XZDwgRGW3BrrkywuK2msPo5dp5GlKPiLd0CSCLVl/MupxPpJPscerpS/QVA==
X-Received: by 2002:a63:4c1d:: with SMTP id z29mr10383024pga.243.1587310165509;
        Sun, 19 Apr 2020 08:29:25 -0700 (PDT)
Received: from [100.124.11.8] ([104.129.199.12])
        by smtp.gmail.com with ESMTPSA id a23sm18968163pfo.145.2020.04.19.08.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 08:29:24 -0700 (PDT)
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk, yuyufen@huawei.com,
        tj@kernel.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416165453.1080463-1-hch@lst.de>
 <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz>
 <70f001cd-eaec-874f-9742-c44e66368a2a@acm.org>
 <20200419075809.GA12222@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a37e947d-c49a-837e-e97d-647ca9d378c3@acm.org>
Date:   Sun, 19 Apr 2020 08:29:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419075809.GA12222@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/20 12:58 AM, Christoph Hellwig wrote:
> On Sat, Apr 18, 2020 at 08:40:20AM -0700, Bart Van Assche wrote:
>>> This can have a sideeffect not only bdi->dev_name will be truncated to 64
>>> chars (which generally doesn't matter) but possibly also kobject name will
>>> be truncated in the same way.  Which may have user visible effects. E.g.
>>> for fs/vboxsf 64 chars need not be enough. So shouldn't we rather do it the
>>> other way around - i.e., let device_create_vargs() create the device name
>>> and then copy to bdi->dev_name whatever fits?
>>
>> How about using kvasprintf() instead of vsnprintf()?
> 
> That is what v1 did, see the thread in response to that on why it isn't
> a good idea.

Are you perhaps referring to patch "[PATCH 3/8] bdi: add a ->dev_name 
field to struct backing_dev_info" 
(https://lore.kernel.org/linux-block/20200416071519.807660-4-hch@lst.de/) 
and also to the replies to that patch? This is what I found in the 
replies: "When driver try to to re-register bdi but without 
release_bdi(), the old dev_name will be cover directly by the newer in 
bdi_register_va(). So, I am not sure whether it can cause memory leak 
for bdi->dev_name."

Has it been considered to avoid that leak by freeing bdi->dev_name from 
unregister_bdi(), e.g. as follows?

void bdi_unregister(struct backing_dev_info *bdi)
{
+	char *dev_name;

	/* make sure nobody finds us on the bdi_list anymore */
	bdi_remove_from_list(bdi);
	wb_shutdown(&bdi->wb);
	cgwb_bdi_unregister(bdi);

	if (bdi->dev) {
		bdi_debug_unregister(bdi);
		device_unregister(bdi->dev);
		bdi->dev = NULL;
+		dev_name = bdi->dev_name;
+		bdi->dev_name = "(unregistered)";
+		kfree(dev_name);
	}

	if (bdi->owner) {
		put_device(bdi->owner);
		bdi->owner = NULL;
	}
}

Thanks,

Bart.
