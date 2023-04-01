Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC08C761A6
	for <linux-block@archiver.kernel.org>; Sat,  1 Apr 2023 02:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjDAC3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 22:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjDAC3E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 22:29:04 -0400
Received: from out-48.mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D93CDBC6
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 19:29:04 -0700 (PDT)
Date:   Fri, 31 Mar 2023 22:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680316142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nk3BO9ozKnNgHpSZ+K/XAgwZZGpDKyN1TJC8W4PiYMA=;
        b=bFZFMdRc23zZazbLH0H7CmHlemGuo1HoqhVyo8DLD3kUfbRL8eKREH+Hw+KMKfNkp0F6p6
        2GSK/citNW0eQCpkjgUoN/rOlKW9MXgDhSNKZJE2zXCbryBqzXJHz7svtlopAeeToW9FA/
        yiE0cJuT0ZiG3oidJyx9UG7LHjm12UU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] block: Rework bio_for_each_segment_all()
Message-ID: <ZCeW6j44aHGI/v5Q@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-2-kent.overstreet@linux.dev>
 <52a5bd5c-d3a1-71d7-e1e5-7965501818bd@squashfs.org.uk>
 <ZCXNDQ6Eslhj+9g5@moria.home.lan>
 <4753802a-685f-ab56-fed2-22d6eb4cfccd@squashfs.org.uk>
 <5ab59623-4317-5aff-5173-d7285b5b224c@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab59623-4317-5aff-5173-d7285b5b224c@squashfs.org.uk>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 31, 2023 at 02:10:15AM +0100, Phillip Lougher wrote:
> On 30/03/2023 19:59, Phillip Lougher wrote:
> > On 30/03/2023 18:55, Kent Overstreet wrote:
> > > On Wed, Mar 29, 2023 at 05:50:27PM +0100, Phillip Lougher wrote:
> > > > There is a problem with the above code, on testing I get the following
> > > > results:
> > > > 
> > > > Index 78018785329, offset 49, bvec.bv_len 1024: In same bio,
> > > > metadata length
> > > > 32780
> > > 
> > > Could you share how you're doing your testing? I set up a basic test
> > > (created images using every compression type, tested reading them) and
> > > so far I'm not able to reproduce this.
> > 
> > I use a very large Squashfs file that triggers the edge case.
> > 
> > That is too big to post, and so I'll see if I can artifically generate
> > a small Squashfs filesystem that triggers the edge case.
> > 
> > Phillip
> > 
> > 
> 
> Hi,
> 
> This is a Google drive link to a file that triggers the issue.
> 
> https://drive.google.com/file/d/1-3-a1BKq62hZGQ6ynioreMSWFMuCV9B4/view?usp=sharing
> 
> To reproduce the issue
> 
> % mount -t squashfs <the file> /mnt -o errors=panic
> 
> then either one of the following will produce a panic
> 
> % ls /mnt
> % find /mnt -type f | xargs wc > /dev/null

Appears to be fixed now - updated version of the patchset is at
https://evilpiepirate.org/git/bcachefs.git bio_folio_iter

Can you confirm, then I'll mail out the updated series?
