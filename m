Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2E2C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418CC21872
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R5dRL8Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfBAPNa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:13:30 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:50753 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbfBAPNa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:13:30 -0500
Received: by mail-it1-f181.google.com with SMTP id z7so9597755iti.0
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMVRe9ECrDEwoXq1aNNCEVoSPMAo0pw3pONdc5E1Hz0=;
        b=R5dRL8ZvKAAPzWUYMN2VlmyJjd0uceXmcy6f9VVSiUV3DRj+AY43sgcWLXk/GA7FKL
         uRXp6ZmTpj0VxGukz8uJOjajHRDJLXazWyqHaA27YfpMcoZWtoyH2HUiIHcImXj5bRvo
         AWbcrE8M1qXjeGEj9fx/f4fyL8Gh/B4Dm2mrVFabIxCwtl3Uosoiwl1e/vrHCVTdNRQu
         6yqJPH+2uH1aVMIG/eeizBaFIvufEugQaMXI8bkvY9WC+iPEm1AoxJHnEUnIn4/WXh9l
         g7SzZeAssVjGBDTUJN1uuTRyWscJpIX+TKKn2+3uy1uUCKM/5fGIXu0Yz3WNkUsmtYO5
         FmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMVRe9ECrDEwoXq1aNNCEVoSPMAo0pw3pONdc5E1Hz0=;
        b=elvt0YDK5k7doswhygMK6SXqqAvIzdgYCsNqHnbVht22J6EM9pOokr5gohMOWPi1aF
         QIqR4mRDSyUpcOTqqhLmWYHC0g/ioTwVKItqH6Vv5DxNcgFvnBP5S8xV3k3dTTBztsEw
         BdXQxzaQR1R0J7Kts5ko1x/jlMYdJ7AGtNHJbdqn3EWhmTAI3fT2Mqg1dUKzcWb4dPx0
         9HzTMtgUFTTMkp59fu5qd8WtRPHSB4LurqpYVEGHHTBJoG23vhUjqvokvNI4KYNdg09E
         XztM9vetY25UmPE5V2LPXvrGw1sj3eB3fbZkUTEQKAW61iId2bDVfawRgw9qK/FuAAL4
         Afew==
X-Gm-Message-State: AHQUAuaqPgcBi2BR+s0ImjCpCQtRaF/c41I3JtcJkVnHTOVz+ZsF/sQr
        moL9nWxd+zvg4fmcHjLGGp62WA==
X-Google-Smtp-Source: AHgI3IaksbDpwB0mZuz3LmWq/g4P0EgQT8rxnP5EIdVp4ewaOCoBzLHC8SwXTdalbfh/ORkDx3byqQ==
X-Received: by 2002:a24:3a0d:: with SMTP id m13mr1546086itm.74.1549034008609;
        Fri, 01 Feb 2019 07:13:28 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h14sm3286076ior.41.2019.02.01.07.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:13:27 -0800 (PST)
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V4
To:     Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com,
        ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190201075557.9249-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2dbeeae6-6c0d-0702-acf4-73226ccf64c4@kernel.dk>
Date:   Fri, 1 Feb 2019 08:13:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201075557.9249-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/19 12:55 AM, Christoph Hellwig wrote:
> The only real user of the T10 OSD protocol, the pNFS object layout
> driver never went to the point of having shipping products, and we
> removed it 1.5 years ago.  Exofs is just a simple example without
> real life users.
> 
> The code has been mostly unmaintained for years and is getting in the
> way of block / SCSI changes, and does not even work properly currently,
> so I think it's finally time to drop it.
> 
> Quote from Boaz:
> 
> "As I said then. It is used in Universities for studies and experiments.
> Every once in a while. I get an email with questions and reports.
> 
> But yes feel free to remove the all thing!!
> 
> I guess I can put it up on github. In a public tree.
> 
> Just that I will need to forward port it myself, til now you guys
> been doing this for me ;-)"
> 
> Now the last time this caused a bit of a stir, but still no actual users,
> not even for SG_IO passthrough commands.  So here we go again, this time
> including removing everything in the scsi and block layer supporting it,
> and thus shrinking struct request.

I'm fine with killing it. You can add my:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to the series.

-- 
Jens Axboe

