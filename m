Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35366 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeFFIlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jun 2018 04:41:09 -0400
Date: Wed, 6 Jun 2018 04:41:05 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Li Wang <liwang@redhat.com>
Cc: Coly Li <colyli@suse.de>, hch@lst.de, darrick.wong@oracle.com,
        snitzer@redhat.com, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Block IO issue in kernel-v4.17
Message-ID: <20180606084105.GA10720@kmo-pixel>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 06, 2018 at 04:37:25PM +0800, Li Wang wrote:
> Hi BIO experts,
> 
> I catch this panic issue on some kind of arches(x86_64, ppc64,
> ppc64le..), it seems the root cause is very probably from BIO changes
> from kernel-4.17-rc7. Plz take a look.

That's the bioset changes, the fix is out and on its way in
