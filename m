Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeHQKh0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 06:37:26 -0400
Date: Fri, 17 Aug 2018 00:35:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Changwei Ge <gechangwei@live.cn>
Cc: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ge.changwei@h3c.com" <ge.changwei@h3c.com>,
        "liu.cong@h3c.com" <liu.cong@h3c.com>,
        "changlimin@h3c.com" <changlimin@h3c.com>
Subject: Re: [RFC] Can DM pass SCSI command to path now?
Message-ID: <20180817073506.GA8653@infradead.org>
References: <HK0PR06MB25611BB82C50809642EFC4C5D53E0@HK0PR06MB2561.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HK0PR06MB25611BB82C50809642EFC4C5D53E0@HK0PR06MB2561.apcprd06.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 16, 2018 at 11:56:48AM +0000, Changwei Ge wrote:
> Hi list,
> 
> Recently, I found that block request can't take SCSI CDB any more.
> 
> So, can we still pass SCSI command to DM device which will clone the 
> request and transfer it real path?

You never could before, as the infrastructure was always missing.
