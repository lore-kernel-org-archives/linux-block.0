Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53474 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751658AbdKGQ23 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Nov 2017 11:28:29 -0500
Date: Tue, 7 Nov 2017 17:28:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: Joe Perches <joe@perches.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] nvme: fix eui_show() print format
Message-ID: <20171107162828.GA26824@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com> <1509703370-20379-4-git-send-email-javier@cnexlabs.com> <20171103125516.GC25186@lst.de> <1509722197.15520.17.camel@perches.com> <2AC384A2-C792-45AF-AF11-89CBC128C527@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2AC384A2-C792-45AF-AF11-89CBC128C527@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Nov 04, 2017 at 12:22:20PM +0100, Javier Gonz�lez wrote:
> > Perhaps this should just become
> > 
> > 	%8ph
> > 
> > without D
> 
> That would be ok with me.

Can you resend a patch for that?
