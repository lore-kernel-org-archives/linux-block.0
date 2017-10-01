Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:20474 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbdJANyz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Oct 2017 09:54:55 -0400
Date: Sun, 1 Oct 2017 16:54:53 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] lightnvm: remove stable extern and unused exported
 symbols
Message-ID: <20171001135452.GA6351@hercules.tuxera.com>
References: <20171001132516.GA5743@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20171001132516.GA5743@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Oct 01, 2017 at 04:25:18PM +0300, Rakesh Pandit wrote:
> Not all exported symbols are being used outside core and there were
> some stable entries in lightnvm.h
> 

If you can replace 'stable' with 'stale' both in subject or body while
picking up that would be great.

Regards,
