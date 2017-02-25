Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdBYSVS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Feb 2017 13:21:18 -0500
Date: Sat, 25 Feb 2017 10:21:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lightnvm: add generic ocssd detection
Message-ID: <20170225182117.GA26447@infradead.org>
References: <20170224171649.27409-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170224171649.27409-1-matias@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 24, 2017 at 06:16:48PM +0100, Matias Bj�rling wrote:
> More implementations of OCSSDs are becoming available. Adding each using
> pci ids are becoming a hassle. Instead, use a 16 byte string in the
> vendor-specific area of the identification command to identify an
> Open-Channel SSD.
> 
> The large string should make the collision probability with other
> vendor-specific strings to be near nil.

No way in hell.  vs is vendor specific and we absolutely can't overload
it with any sort of meaning.  Get OCSSD support properly standardized and
add a class code for it.  Until then it's individual PCI IDs.
