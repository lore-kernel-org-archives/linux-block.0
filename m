Return-Path: <SRS0=B3LW=3V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30EC33CB7
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 00:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE4320661
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 00:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AlBMjDdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBAAxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:53:47 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54848 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgBAAxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 19:53:47 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so3695481pjb.4
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 16:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tc8ar+zPlE2mflta9AzRevX9yYQr1iSscRoF7kXeb8o=;
        b=AlBMjDdvPjgeI/eGL89AQ49XgQmrU/+1ozzmtDR5dHvi6yoogM7awYpQ3BkwGcbVYV
         M1s+faeZNiOPts5oOD18nSVaEWe6Tq0280wPaPZ44Sf4nlvLTmFmvire62nOSnezG8V3
         kB7Yi8Esmzg+8masoI44VX1hQGDU3cIbjAw9eSnbhVR3+mjaXQjImZ+IRzqvaNxg5VMf
         Uu7wzxAXhTW9dGMMKwq5ISWZd7sJ2JO4ROUIIDfNvsadjrfkihOshvSZ1wGG/XLoTVaj
         PeXXkLr9E0nrKxD7VqSS2R1o5f+DfDnXuyOIhtDKYQmc+JEkFwklNlkFtZ2fV/4X+S3d
         fJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tc8ar+zPlE2mflta9AzRevX9yYQr1iSscRoF7kXeb8o=;
        b=NTSRVGAB2q4TLtu2P5zLz1rTy2ySB/EFsVw3cHGpaKgzf6uT2apAQZHaYY+yrbjXl4
         yxI+t5wKgHQTZ7+OxiSidkIwTH4ichnuGKC+1DxqQdrdAey5YGxa6fA6GMYCgdwWOjiG
         YMmODdjWm/FoFtOdOawieIOFpO/OhUr5ENo1FY28m2/fvmZWAPwDPPAiEoqej53aDias
         jioj3y1rq5T09PlvBq5Y8Erh155YtLrm9r5RAw72Gkhl0exEmUltmyYVPZpwAiQ33ikw
         TGb0Cy2pcNjI01lZJ76U1G+TZAnKWy4hpw5omxO0rnUmCiTmTwrAG+DFdnrIhnoluQeK
         W7PQ==
X-Gm-Message-State: APjAAAUAtnVLZAK4sFSweZOrAPNuBQNLbbTnNItOjITFkm8RAlucVkRZ
        kZfk/Ruyn6gXIsGeq6uR95phGg==
X-Google-Smtp-Source: APXvYqzikgNTMcmEplcDqmJyDdxwtw9uBCUErp4noGehjtNn15shqpInHU4QEVPviXn1v7bNUq4q3A==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id b44mr15962672pjc.9.1580518426468;
        Fri, 31 Jan 2020 16:53:46 -0800 (PST)
Received: from google.com ([2620:15c:201:0:7f8c:9d6e:20b8:e324])
        by smtp.gmail.com with ESMTPSA id p24sm11163167pff.69.2020.01.31.16.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 16:53:45 -0800 (PST)
Date:   Fri, 31 Jan 2020 16:53:41 -0800
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 0/9] Inline Encryption Support
Message-ID: <20200201005341.GA134917@google.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117085210.GA5473@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 17, 2020 at 12:52:10AM -0800, Christoph Hellwig wrote:
> Hi Satya,
> 
> On Wed, Jan 08, 2020 at 10:43:05AM -0800, Satya Tangirala wrote:
> > The fallback actually is in a separate file, and the software only fields
> > are not allocated in the hardware case anymore, either - I should have
> > made that clear(er) in the coverletter.
> 
> I see this now, thanks.  Either the changes weren't pushed to the
> fscrypt report by the time I saw you mail, or I managed to look at a
> stale local copy.
> 
> > Alright, I'll look into this. I still think that the keyslot manager
> > should maybe go in a separate file because it does a specific, fairly
> > self contained task and isn't just block layer code - it's the interface
> > between the device drivers and any upper layer.
> 
> So are various other functions in the code like bio_crypt_clone or
> bio_crypt_should_process.  Also the keyslot_* naming is way to generic,
> it really needs a blk_ or blk_crypto_ prefix.
> 
> > > Also what I don't understand is why this managed key-slots on a per-bio
> > > basis.  Wou;dn't it make a whole lot more sense to manage them on a
> > > struct request basis once most of the merging has been performed?
> > I don't immediately see an issue with making it work on a struct request
> > basis. I'll look into this more carefully.
> 
> I think that should end up being simpler and more efficient.
So I tried reading through more of blk-mq and the IO schedulers to figure
out how to do this. As far as I can tell, requests may be merged with
each other until they're taken off the scheduler. So ideally, we'd
program a keyslot for a request when it's taken off the scheduler, but
this happens from within an atomic context. Otoh, programming a keyslot
might cause the thread to sleep (in the event that all keyslots are in use
by other in-flight requests). Unless I'm missing something, or you had some
other different idea in mind, I think it's a lot easier to stick to letting
blk-crypto program keyslots and manage them per-bio...
