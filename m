Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8068C433DF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D089D2070B
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgG3IPD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:15:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729978AbgG3IME (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 04:12:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C842B1E1;
        Thu, 30 Jul 2020 08:12:15 +0000 (UTC)
Date:   Thu, 30 Jul 2020 10:12:02 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, Sebastian.Chlad@suse.com,
        daniel.wagner@suse.com, hare@suse.com, osandov@fb.com
Subject: Re: [PATCH] common/multipath-over-rdma: make block scheduler
 directory optional
Message-ID: <20200730081202.ppcwyzbiqj6pahhe@beryllium.lan>
References: <20200729152113.1250-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729152113.1250-1-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Luis,

[cc: Omar]

blktests patches should have a 'PATCH blktests' subject prefix.

On Wed, Jul 29, 2020 at 03:21:13PM +0000, Luis Chamberlain wrote:
> We currently fail if the following tests if the directory
> /lib/modules/$(uname -r)/kernel/block does not exist. Just make
> this optional. Older distributions won't have this directory.

It's not just older distributions. If the I/O schedulers are build in
there wont be any block directory.

> srp/001
> srp/002
> srp/013
> srp/014
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
