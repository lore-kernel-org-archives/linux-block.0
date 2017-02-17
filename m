Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37213 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754199AbdBQI63 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 03:58:29 -0500
Subject: Re: [PATCH 2/2] block/sed-opal: allocate struct opal_dev dynamically
To: Christoph Hellwig <hch@lst.de>, scott.bauer@intel.com,
        keith.busch@intel.com, jonathan.derrick@intel.com, axboe@fb.com
References: <20170216201053.1190-1-hch@lst.de>
 <20170216201053.1190-2-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <10ec775b-cbdc-7cac-336b-015d97c486de@suse.de>
Date: Fri, 17 Feb 2017 09:58:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170216201053.1190-2-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/16/2017 09:10 PM, Christoph Hellwig wrote:
> -enum opal_response_token {
> -	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
> -	OPAL_DTA_TOKENID_SINT = 0xe1,
> -	OPAL_DTA_TOKENID_UINT = 0xe2,
> -	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
> -	OPAL_DTA_TOKENID_INVALID = 0X0

Nit, here's a capital 'X' that slipped in


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
