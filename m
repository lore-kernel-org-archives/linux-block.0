Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41927 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdFZQnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 12:43:41 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Robert Elliott <elliott@hpe.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] sd: add support for TCG OPAL self encrypting disks
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170619122646.32666-1-hch@lst.de>
        <20170619122646.32666-2-hch@lst.de> <20170626111047.GA16273@lst.de>
Date: Mon, 26 Jun 2017 12:43:27 -0400
In-Reply-To: <20170626111047.GA16273@lst.de> (Christoph Hellwig's message of
        "Mon, 26 Jun 2017 13:10:47 +0200")
Message-ID: <yq1tw327l8w.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Christoph,

> ping?

Looks good to me. I'll queue it up for 4.13 as soon as Linus has pulled
in the ata bits.

-- 
Martin K. Petersen	Oracle Linux Engineering
