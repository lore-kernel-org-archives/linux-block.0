Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8985C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71BB64E20
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 20:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhBXU3a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbhBXU31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 15:29:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BD6C06178C
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 12:28:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v15so3135006wrx.4
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 12:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m1IpK7yU5BzhpwN3PH2LaUmGjgI0MX55nsoHz2Oanwk=;
        b=PQg0nEgiPbJqV4p0ayQroaiTNmERupFumGeqTXFVhXbf0jozxj8KUYTe9SxgpWSDQ2
         UELKClpWyCT3NBdC1nnPpN1ur6uX95av0XFSkG9z2nws9oZIvpKHUIOOWmr96/GAnSRF
         HePjeG0hwDOeGq76CKjUHtXYzeVLG6OabOvKh2lyjG9ViFcUJ6DoAmPCBbHExr+/h7RG
         NLKkMZDSOZpVNAIHY1WJ+c9E+n9FfbVv/xMpEF0vy890u/KnMyqAnhnMT2F3atjthqrs
         K/dxlIjdGtSavKQ1nQuESgK7yvVlPaGZCwAakqHDZzBXsJf/w1QUcz4AE0Do0I5P6sUI
         YdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m1IpK7yU5BzhpwN3PH2LaUmGjgI0MX55nsoHz2Oanwk=;
        b=ZVRYvVx749d26qABip5w7jftGQ7q7JhTRaQEVYJmCU1ofdn5D9mi9nhBnc2WgTza37
         uZE7Jk9ulFdxZEwgpeQB0f60FEgyeeOXsPdIohr2jSikQt2NrbsOpZBBc+sgEu1TGKFV
         /yjYJpqKKef7Y0mQg/qzSaXbunAAF8+slAoZwGrzeC4xPDav0lmFWWhqXmcyzGJEqz2d
         x2gTc0A0QeGuj3UIPVY14lPREnQANOycIaXDmw9PzpdZlv0UkrocnCH6IFfpqE7xO+OF
         4mwhaMT00n3RPx9y15U3oyDd7QCmXmssV4KYwbYr/4yv6bVRX/mPzjDYjngKXveqlm66
         JxuA==
X-Gm-Message-State: AOAM5333GmwTFd6X1CattXypmeKJiDuUJ+M0qa9QchsdMROsxQhhefcK
        u8qLE9/of2j0OAtO0AcSsmEw/g==
X-Google-Smtp-Source: ABdhPJxpLrsJ7DPmn1iln4ByKTUgVl4ugGswSie3vQNAOxM2zIn82FT5f+IfXJMaX3lFxRASD+InFw==
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr25482429wrs.236.1614198525920;
        Wed, 24 Feb 2021 12:28:45 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id z11sm4531166wmi.35.2021.02.24.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 12:28:45 -0800 (PST)
Date:   Wed, 24 Feb 2021 21:28:43 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: [PATCH V5 1/2] nvme: enable char device per namespace
Message-ID: <20210224202843.glv4c7uaifxzknmw@mpHalley.localdomain>
References: <20210222190107.8479-1-javier.gonz@samsung.com>
 <20210222190107.8479-2-javier.gonz@samsung.com>
 <20210224164443.GA11338@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210224164443.GA11338@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24.02.2021 17:44, Christoph Hellwig wrote:
>> +static inline bool nvme_dev_is_generic(struct device *dev)
>> +{
>> +	return dev->class == nvme_ns_class;
>> +}
>> +
>> +static inline bool nvme_ns_is_generic(struct nvme_ns *ns)
>> +{
>> +	return !!ns->minor;
>> +}
>
>What does is_generic mean here?  In doubt add a few comments..

Will do.

>
>>  	/* some standard values */
>> @@ -2241,6 +2270,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>>  	return 0;
>>
>>  out_unfreeze:
>> +	/*
>> +	 * When the device does not support any of the features required by the
>> +	 * kernel (or viceversa), hide the block device. We can still rely on
>> +	 * the namespace char device for submitting IOCTLs
>> +	 */
>> +	ns->disk->flags |= GENHD_FL_HIDDEN;
>> +
>
>The out_unfreeze case also handles all kinds of real error, so this needs
>to move into a better spot, and probably check a specific error code
>or even explicit indicator.

Ok.

>
>> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
>> +{
>> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
>
>> +	struct nvme_ns *ns = container_of(file->f_inode->i_cdev,
>> +				struct nvme_ns, cdev);
>
>Maybe add a little cdev_to_ns() helper?

Ok.
>
>> -	if (nvme_update_ns_info(ns, id))
>> -		goto out_put_disk;
>> +	nvme_update_ns_info(ns, id);
>
>I don't think we can simplify ignore all errors here.

Sounds good.

>
>> +static inline struct nvme_ns *nvme_get_ns_from_cdev(struct device *dev)
>> +{
>> +	return dev_get_drvdata(dev);
>> +}
>
>I think we can keep this in core.c.

Perfect.

Will send a new version.
