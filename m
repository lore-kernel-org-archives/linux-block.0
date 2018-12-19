Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81244C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 04:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2723521850
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 04:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="avHWgBWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeLSEbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:31:25 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:33930 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeLSEbX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 23:31:23 -0500
Received: by mail-pf1-f180.google.com with SMTP id h3so9229118pfg.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 20:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8lZnIFHnbUlesfkdotU16xZ7sU13abc5RiWhykTNEM=;
        b=avHWgBWWGFaJmB2+rxy89Fjj4uGK+SMCnWMhtsWAUWxrKY8aJ+Ypg15esMnX3KAKeT
         sb1Rsyyd5NqQNPtOBPJE3URo+KLIA+zOgS3IeTnp2ZtIZaz0MdCegn9U5cuoAglCtMuV
         FaSjbd4lLESRpMAuaruEP0MNcKQp04SuIWwR2d8a+HLQzIfzcXQOUin6quP4rbNs64h+
         /GzKtcZ7C1pvqrRqJMgGJZoOXq5Ee5XUkp64LoLrsXCbGFtCxia0kDAYbdgtZzYCN0Ce
         qvuOpCUSjSiWK/HsmMLPvfSkPSwHkBR2XFZNPsmsz7OeEqASO0HrboWEV5j8MX+Z2Yyl
         DLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8lZnIFHnbUlesfkdotU16xZ7sU13abc5RiWhykTNEM=;
        b=UvmmbMj1WcbTOjmabQRvrEKIeAfUxchzKdP+OWVDrWDT2w9A4RxEH71c/KQXg91kVl
         sNh5e8oXD9CSHzq/uTYMKcrPYzlte+GToWlECcVLp0xpUnaApcm/2St0RkdGKxWMf2og
         YvTsWoiRkyRbM3Op7o06m6IxC5hqaVtroi1c9u4ZwLb1hHDIqHjpg8qPjz1ml5o0dlUU
         AbMq8vSp8CZGJANcJhc9rP5jWNPcp7PfyjEC6VY8lxY8tYt+gPZrAqYGAJe1jtAZu6JB
         2oLD3y2qm1vQ7QIM4bGyBx9SNtXPUmQA0xQgq52JZBAekufhW4Hzs/EqHNDjZZcNsEHV
         QxUw==
X-Gm-Message-State: AA+aEWbHEZpIkPmYlhE4mh2qHSJVFI++Fi+dYjZ6kLKiYcfD/jC6IVQA
        sxJEBjRFFmifpo6phEdmHHE61aCcBMz8eg==
X-Google-Smtp-Source: AFSGD/U1oMlvtkaKcgP6yiIq2ItcMs20BcMGZyFrCsK4lnOXhAYTnRK0OcUuxSUqQUDsfC2xtGQCKg==
X-Received: by 2002:a63:3602:: with SMTP id d2mr17690400pga.404.1545193882634;
        Tue, 18 Dec 2018 20:31:22 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i1sm25277408pgb.46.2018.12.18.20.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 20:31:21 -0800 (PST)
Subject: Re: remove the "clustering" flag V2
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20181213151710.30036-1-hch@lst.de> <20181218070826.GA1787@lst.de>
 <yq136qui1q3.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f80d28bc-e76a-0c9d-cbd6-34c7082963d8@kernel.dk>
Date:   Tue, 18 Dec 2018 21:31:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <yq136qui1q3.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 9:23 PM, Martin K. Petersen wrote:
> 
> Christoph,
> 
>> can we get this reviewed and merge before the end of the merge window?
>> That gets the clustering put of the way for the multipage-biovec work
>> from Ming which we want to land in the block tree early in the next
>> merge window.
> 
> I have been somewhat hesitant to apply this just before the merge
> window.  However, I did go through it fairly carefully and since it's a
> mostly mechanical change, I did apply it.
> 
> There were a few things I needed to tweak by hand and patch 9 forgot to
> update myrs and myrb.
> 
> I left patch 10 for Jens to merge later (unless he acks it for me to
> pull in).

You can add my reviewed-by to 10 and add that one too, that makes more
sense than me adding it for a post-merge pull. But either way works
for me.

-- 
Jens Axboe

