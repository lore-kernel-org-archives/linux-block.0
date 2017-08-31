Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:57504 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751655AbdHaUKi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 16:10:38 -0400
Subject: Re: [PATCH] block: sed-opal: Set MBRDone on S3 resume path if TPER is
 MBREnabled
To: Scott Bauer <scott.bauer@intel.com>, linux-block@vger.kernel.org
Cc: david.fugate@intel.com, axboe@fb.com, hch@infradead.org,
        rafael.antognolli@intel.com
References: <20170831174238.2714-1-scott.bauer@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <f8da2845-bc33-8afb-2695-958b0a7425f1@intel.com>
Date: Thu, 31 Aug 2017 14:10:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170831174238.2714-1-scott.bauer@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey Scott,
> +static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
> +{
> +	u8 mbr_done_tf = 1;
> +	const struct opal_step mbrdone_step [] = {
> +		{ opal_discovery0, },
> +		{ start_admin1LSP_opal_session, key },
> +		{ set_mbr_done, &mbr_done_tf },
Do you need to end_opal_session here?

> +		{ NULL, }
> +	};
> +
