Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34704 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbdEIOVc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 May 2017 10:21:32 -0400
MIME-Version: 1.0
In-Reply-To: <149427743028.38205.11259335580114937340.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149427742346.38205.12361226658239922137.stgit@dwillia2-desk3.amr.corp.intel.com>
 <149427743028.38205.11259335580114937340.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 May 2017 16:21:30 +0200
Message-ID: <CAMuHMdXL-nWk7nWkjJL9Zd9ObeAdjLH-OTKGWxFHFvLOPo_WmQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] device-dax: kill NR_DEV_DAX
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 8, 2017 at 11:03 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> There is no point to ask how many device-dax instances the kernel should
> support. Since we are already using a dynamic major number, just allow
> the max number of minors by default and be done. This also fixes the
> fact that the proposed max for the NR_DEV_DAX range was larger than what
> could be supported by alloc_chrdev_region().
>
> Fixes: ba09c01d2fa8 ("dax: convert to the cdev api")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
