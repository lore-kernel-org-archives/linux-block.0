Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdCMNhJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2017 09:37:09 -0400
Date: Mon, 13 Mar 2017 06:36:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Umesh Patel <Umesh.Patel@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blk_init_queue vs blk_alloc_queue
Message-ID: <20170313133629.GA29232@infradead.org>
References: <CY1PR0401MB1353F4C37A081FCB3E6E145EE1250@CY1PR0401MB1353.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CY1PR0401MB1353F4C37A081FCB3E6E145EE1250@CY1PR0401MB1353.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 13, 2017 at 09:14:12AM +0000, Umesh Patel wrote:
> Hello,
> 
> I Would like to know difference between blk_init_queue and blk_alloc_queue API.
> Can anyone explain when to use what ?

The short answer is that you should neither.  The long answer is that
you should send a link to your driver source if you want anyone to help
you.
