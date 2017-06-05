Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36205 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFETaR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2017 15:30:17 -0400
Date: Mon, 5 Jun 2017 15:30:08 -0400
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Robert Elliott <elliott@hpe.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: TCG Opal support for libata
Message-ID: <20170605193008.GA9399@htj.duckdns.org>
References: <20170604124225.27032-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170604124225.27032-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jun 04, 2017 at 02:42:19PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds support for using our new generic TCG OPAL code with
> SATA disks, and as side effect for SCSI disks (although so far it doesn't
> seem like none of those actually exist).

Applied 1-5 to libata/for-4.13.  Updated 4 for line continuation style
consistency as pointed out by Sergei.

Thanks.

-- 
tejun
