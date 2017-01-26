Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:36058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbdAZNRP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 08:17:15 -0500
Date: Thu, 26 Jan 2017 05:17:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Eric Blake <eblake@redhat.com>, Alex Bligh <alex@alex.org.uk>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Josef Bacik <jbacik@fb.com>,
        Jens Axboe <axboe@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Alex Gartrell <agartrell@fb.com>
Subject: Re: [Nbd] [PATCH 4/4] nbd: add a nbd-control interface
Message-ID: <20170126131709.GA26618@infradead.org>
References: <1485186762.21123.1@smtp.office365.com>
 <20170124071152.GB13251@kroah.com>
 <1485352053.5902.0@smtp.office365.com>
 <CAK8P3a10K-8GwwcZLd4HwYHzxcB8cwww3y73np_Th65af7m6gQ@mail.gmail.com>
 <F7E2FE6F-B7A8-4A36-854D-AE1620D88762@fb.com>
 <5F1F69A4-CDE1-4519-9FB4-C6B1DED5BBAE@alex.org.uk>
 <20170125213004.GA6141@kroah.com>
 <68e14c2e-e96e-ff8d-bd8a-0754fb970e77@redhat.com>
 <20170126084047.GA9242@infradead.org>
 <20170126091758.GB31667@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170126091758.GB31667@kroah.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 26, 2017 at 10:17:58AM +0100, Greg KH wrote:
> Ok, but do you feel the "loop method" of using a char device node to
> create/control these devices is a good model to follow for new devices
> like ndb?

Yes. We've done the same for NVMe over fabrics.
