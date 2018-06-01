Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeFAINc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 04:13:32 -0400
Date: Fri, 1 Jun 2018 01:13:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Cc: "Jens Axboe <axboe@kernel.dk>; Hannes Reinecke <hare@suse.com>; Johannes
        Thumshirn <jthumshirn@suse.de>; Omar Sandoval <osandov@fb.com>; Mike
        Snitzer <snitzer@redhat.com>; Shaohua Li <shli@fb.com>; Bart Van Assche
        <bart.vanassche@wdc.com> ; Keith Busch <keith.busch@intel.com>; Ming Lei"
        <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org; Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
Message-ID: <20180601081330.GA13067@infradead.org>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 28, 2018 at 02:43:09PM +0100, Ladvine D Almeida wrote:
> 
> This patch introduces new variable under bio structure to
> facilitate inline encryption. This variable is used to
> associate I/O requests to crypto information.

This seems to be missing a whole lot of context.  Where is the whole
series showing what you are trying to do?
