Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28234C4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 11:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CBA20788
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 11:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgCWLJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:09:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgCWLJX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 07:09:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 900F7AC90;
        Mon, 23 Mar 2020 11:09:22 +0000 (UTC)
Date:   Mon, 23 Mar 2020 12:09:21 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests v3 1/4] Make _exit_null_blk remove all null_blk
 device instances
Message-ID: <20200323110921.hbs3e34gwqgnl4p2@beryllium.lan>
References: <20200320222413.24386-1-bvanassche@acm.org>
 <20200320222413.24386-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320222413.24386-2-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 20, 2020 at 03:24:10PM -0700, Bart Van Assche wrote:
> Instead of making every test remove null_blk device instances before calling
> _exit_null_blk(), move the null_blk device instance removal code into
> _exit_null_blk().
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
