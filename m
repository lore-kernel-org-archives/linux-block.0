Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45731 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdEPVRi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2017 17:17:38 -0400
Date: Tue, 16 May 2017 14:17:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Richard <richard@aaazen.com>
Cc: linux-block@vger.kernel.org
Subject: Re: Bug 109761 FreeBSD UFS2 file systems are not recognized on MS
 DOS (MBR) partitions
Message-ID: <20170516211737.GA29431@infradead.org>
References: <alpine.LNX.2.20.1705161353060.20651@thursday.test>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1705161353060.20651@thursday.test>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 16, 2017 at 02:07:49PM -0700, Richard wrote:
> To allow FreeBSD filesystems to be recognized on Linux,
> I submitted the following bug and patch in December 2015.
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=109761
> 
> The patch still works on current kernels (4.4.68 4.9.28 4.12.1-rc1)

Please send the patch to this list.  Take a look at
Documentation/process/submitting-patches.rst in the kernel tree for the
finer details on patch format.
