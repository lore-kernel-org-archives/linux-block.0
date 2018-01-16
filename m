Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47842 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750830AbeAPX2h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 18:28:37 -0500
Message-ID: <1516145316.14734.11.camel@HansenPartnership.com>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] A high-performance userspace block
 driver
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>
Date: Tue, 16 Jan 2018 15:28:36 -0800
In-Reply-To: <20180116232335.GM8249@thunk.org>
References: <20180116145240.GD30073@bombadil.infradead.org>
         <20180116232335.GM8249@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-01-16 at 18:23 -0500, Theodore Ts'o wrote:
> On Tue, Jan 16, 2018 at 06:52:40AM -0800, Matthew Wilcox wrote:
> > 
> > 
> > I see the improvements that Facebook have been making to the nbd
> > driver, and I think that's a wonderful thing.  Maybe the outcome of
> > this topic is simply: "Shut up, Matthew, this is good enough".
> > 
> > It's clear that there's an appetite for userspace block devices;
> > not for swap devices or the root device, but for accessing data
> > that's stored in that silo over there, and I really don't want to
> > bring that entire mess of CORBA / Go / Rust / whatever into the
> > kernel to get to it, but it would be really handy to present it as
> > a block device.
> 
> ... and using iSCSI was too painful and heavyweight.

>From what I've seen a reasonable number of storage over IP cloud
implementations are actually using AoE.  The argument goes that the
protocol is about ideal (at least as compared to iSCSI or FCoE) and the
company behind it doesn't seem to want to add any more features that
would bloat it.

James
