Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDEDC4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 16:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DB26101B
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhG1QS0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 12:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230009AbhG1QRz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 12:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627489071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zr6iO5EfhirdLS6EThCnFQV2o1b+d2YY8eAPyEtxmt4=;
        b=c+WJ7HuWuSNMGcc5XM0H3I3vi9SHM0XMuRIK0CkJ+7KvnWoZy258G8iOdv5AASyXynjA8h
        /KWcYwpTM0g8bod/o498zKQ2I5wxhUlaO8ZcVycznVMAarSmL8Ma3Q4c/zsGolFaKw+4Kh
        a0sOKex6jgXKU0p+vp5oQSn52KcPZp8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-psI8dtTgOeCfvr71Ul-nQQ-1; Wed, 28 Jul 2021 12:17:50 -0400
X-MC-Unique: psI8dtTgOeCfvr71Ul-nQQ-1
Received: by mail-qk1-f199.google.com with SMTP id i15-20020a05620a150fb02903b960837cbfso1927222qkk.10
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 09:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zr6iO5EfhirdLS6EThCnFQV2o1b+d2YY8eAPyEtxmt4=;
        b=Kux274KVXZB+XWrG6t31MiILrRpk0PGJF6TE2epLgfvc89o78qHUAxL/OFm7OLVH73
         drG2N72jC0yYvXIqpqdGgg9uwZxshv3FiO8SmYeKe0tNH02154qB2IG3CSFSVPrQtkam
         E3JAQFe2wF65UvWmyFGKcpLXAkDzJx+L1I9OCzFbg4SjAgUrhsFuNnVVl+zHNB/6cni7
         gnkKoqj3TqsMZ+8l3J2J8XdCorw4pllqq2c5jIcTb9o8vhhghcWik4izQwLQXtZnS5FR
         KFaI7T5aCuIqQtqqd4Iy2T4eHlfa00WsG5b/LQK6kmqKsMoI6JqG1k9fsJWNRQf4zYCi
         1n3A==
X-Gm-Message-State: AOAM532sP69HcMn+YPkxlVQUdths9PThsEi2qJGjIKmi4LdRTMgtA9dC
        hurQxb1B+tU3bCmZd20z3tGw3K7dMVD8/t4DUlQ+i8qoERLjd6fd8tRyr/l6F4j37DNu4906PT9
        MQ8e4doFbi2ftIKlKtj1EAw==
X-Received: by 2002:ac8:4f14:: with SMTP id b20mr316076qte.236.1627489069715;
        Wed, 28 Jul 2021 09:17:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq/FUgQMZBFspmTaanQXJhzUXM+wyidC3InkD7kOm5mOKJeD1mRH+Pq0A4ZiaR+yacRvY5Xg==
X-Received: by 2002:ac8:4f14:: with SMTP id b20mr316061qte.236.1627489069494;
        Wed, 28 Jul 2021 09:17:49 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d4sm141513qty.15.2021.07.28.09.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:17:49 -0700 (PDT)
Date:   Wed, 28 Jul 2021 12:17:48 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: use regular gendisk registration in device mapper
Message-ID: <YQGDLIbefYvSHJqi@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <YQAtNkd8T1w/cSLc@redhat.com>
 <20210727160226.GA17989@lst.de>
 <YQAxyjrGJpl7UkNG@redhat.com>
 <9c719e1d-f8da-f1f3-57a9-3802aa1312d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c719e1d-f8da-f1f3-57a9-3802aa1312d4@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27 2021 at  4:38P -0400,
Milan Broz <gmazyland@gmail.com> wrote:

> On 27/07/2021 18:18, Mike Snitzer wrote:
> > On Tue, Jul 27 2021 at 12:02P -0400,
> > Christoph Hellwig <hch@lst.de> wrote:
> > 
> >> On Tue, Jul 27, 2021 at 11:58:46AM -0400, Mike Snitzer wrote:
> >>>> This did not make a different to my testing
> >>>> using dmsetup and the lvm2 tools.
> >>>
> >>> I'll try these changes running through the lvm2 testsuite.
> >>
> >> Btw, is ther documentation on how to run it somewhere?  I noticed
> >> tests, old-tests and unit-tests directories, but no obvious way
> >> to run them.
> > 
> > I haven't tracked how it has changed in a while, but I always run:
> > make check_local
> > 
> > (but to do that you first need to ./configure how your distro does
> > it... so that all targets are enabled, etc. Then: make).
> > 
> > Will revisit this shortly and let you know if my process needed to
> > change at all due to lvm2 changes.
> 
> BTW it would be also nice to run cryptsetup testsuite as root - we do a lot
> of DM operations there (and we depend on sysfs on some places).
> 
> You can just run configure, make and then make check.

Once I installed all deps, I got all but one passing with Christoph's changes:

Block_size: 512, Data_size: 256000B, FEC_roots: 9, Corrupted_bytes: 4 [no-superblock][one_device_test]Usage: lt-veritysetup [-?Vv] [-?|--help] [--usage] [-V|--version]
        [--cancel-deferred] [--check-at-most-once] [--data-block-size=bytes]
        [--data-blocks=blocks] [--debug] [--deferred] [--fec-device=path]
        [--fec-offset=bytes] [--fec-roots=bytes] [--format=number]
        [-h|--hash string] [--hash-block-size=bytes] [--hash-offset=bytes]
        [--ignore-corruption] [--ignore-zero-blocks] [--no-superblock]
        [--panic-on-corruption] [--restart-on-corruption]
        [--root-hash-file=STRING] [--root-hash-signature=STRING]
        [-s|--salt hex string] [--uuid=STRING] [-v|--verbose]
        [OPTION...] <action> <action-specific>
-s=e48da609055204e89ae53b655ca2216dd983cf3cb829f34f63a297d106d53e2d: unknown option
[N/A, test skipped]
FEC repair failed
FAILED backtrace:
500 ./verity-compat-test
FAIL: verity-compat-test

Seems like a test bug.

Mike

