Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ECCC4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 07:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896816052B
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 07:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhG1HG7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 03:06:59 -0400
Received: from verein.lst.de ([213.95.11.211]:52613 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhG1HG7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 03:06:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DABE767373; Wed, 28 Jul 2021 09:06:55 +0200 (CEST)
Date:   Wed, 28 Jul 2021 09:06:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [dm-devel] use regular gendisk registration in device mapper
Message-ID: <20210728070655.GA5086@lst.de>
References: <20210725055458.29008-1-hch@lst.de> <YQAtNkd8T1w/cSLc@redhat.com> <20210727160226.GA17989@lst.de> <YQAxyjrGJpl7UkNG@redhat.com> <9c719e1d-f8da-f1f3-57a9-3802aa1312d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c719e1d-f8da-f1f3-57a9-3802aa1312d4@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27, 2021 at 10:38:16PM +0200, Milan Broz wrote:
> BTW it would be also nice to run cryptsetup testsuite as root - we do a lot
> of DM operations there (and we depend on sysfs on some places).

It already doesn't seem very happy in current mainline for me:

=======================
13 of 17 tests failed
(12 tests were not run)
=======================

but this series doesn't seem to change anything.

A lot of the not run tests seem to be due to broken assumptions
that some code must be modular.  E.g. my kernel has scsi_debug built
in, but it complains like this:

modprobe: ERROR: ../libkmod/libkmod.c:586 kmod_search_moddep() could not open moddep file '/lib/module'
modprobe: FATAL: Module scsi_debug not found in directory /lib/modules/5.14.0-rc3+
