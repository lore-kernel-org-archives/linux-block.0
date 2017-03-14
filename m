Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34606 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdCNVHy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2017 17:07:54 -0400
Received: by mail-pg0-f46.google.com with SMTP id 141so273732pgd.1
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2017 14:07:53 -0700 (PDT)
Date: Tue, 14 Mar 2017 14:07:05 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: Re: [PATCH 0/4] block: callback-based statistics
Message-ID: <20170314210705.GC2352@vader.DHCP.thefacebook.com>
References: <cover.1489524591.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1489524591.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Mar 14, 2017 at 02:03:27PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This patchset generalizes the blk-stats infrastructure to allow users to
> register a callback to be called at a given time with the statistics of
> requests completed during that window. Writeback throttling and hybrid
> polling are converted to the new infrastructure. The ultimate goal is to
> use this infrastructure for the mq I/O scheduler.
> 
> The details are in patch 4, which is the actual conversion. Patches 1-3
> are preparation cleanups.

FYI, the diff of block/blk-stat.[ch] is a pain to read. It's easier to
just apply the patches and look at the whole files.
