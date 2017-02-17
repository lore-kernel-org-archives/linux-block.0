Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41319 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751646AbdBQJLl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 04:11:41 -0500
Date: Fri, 17 Feb 2017 10:11:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, scott.bauer@intel.com,
        keith.busch@intel.com, jonathan.derrick@intel.com, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] block/sed-opal: allocate struct opal_dev
        dynamically
Message-ID: <20170217091139.GA19393@lst.de>
References: <20170216201053.1190-1-hch@lst.de> <20170216201053.1190-2-hch@lst.de> <10ec775b-cbdc-7cac-336b-015d97c486de@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10ec775b-cbdc-7cac-336b-015d97c486de@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 17, 2017 at 09:58:27AM +0100, Johannes Thumshirn wrote:
> On 02/16/2017 09:10 PM, Christoph Hellwig wrote:
> > -enum opal_response_token {
> > -	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
> > -	OPAL_DTA_TOKENID_SINT = 0xe1,
> > -	OPAL_DTA_TOKENID_UINT = 0xe2,
> > -	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
> > -	OPAL_DTA_TOKENID_INVALID = 0X0
> 
> Nit, here's a capital 'X' that slipped in

I just moved the existing definition around 1:1.
