Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:53145 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbdEDL1j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 07:27:39 -0400
Date: Thu, 4 May 2017 04:27:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: mb@lightnvm.io, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 1/2] lightnvm: create cmd before allocating request
Message-ID: <20170504112738.GA22269@infradead.org>
References: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 03, 2017 at 11:19:04AM +0200, Javier Gonz�lez wrote:
> Create nvme command before allocating a request using
> nvme_alloc_request, which uses the command direction. Up until now, the
> command has been zeroized, so all commands have been allocated as a
> read operation.

Hah.. Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
