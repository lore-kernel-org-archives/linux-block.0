Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55968 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbcGWMna (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sat, 23 Jul 2016 08:43:30 -0400
Subject: Re: [PATCH 4/6] block: Add 'zoned' sysfs queue attribute
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1468934439-93579-1-git-send-email-hare@suse.de>
 <1468934439-93579-5-git-send-email-hare@suse.de>
 <yq1wpkd9zbc.fsf@sermon.lab.mkp.net>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Damien Le Moal <damien.lemoal@hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f39f2a46-75ab-a770-025f-6807c2f14413@suse.de>
Date: Sat, 23 Jul 2016 14:43:27 +0200
MIME-Version: 1.0
In-Reply-To: <yq1wpkd9zbc.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/22/2016 10:45 PM, Martin K. Petersen wrote:
>>>>>> "Hannes" == Hannes Reinecke <hare@suse.de> writes:
> 
> Hannes> Add a sysfs queue attribute 'zoned' to display the zone layout
> Hannes> for zoned devices.
> 
> Not quite one value per file :(
> 
Yes.
But I wanted to display the zone layout in a concise way allowing
user-space programs to determine the zone layout without having to
issue a 'REPORT ZONES' command themselves.
I found it slightly pointless to add one sysfs entry per zone,
and at the same time a simple 'zone_size' attribute wouldn't cover all
possibilities.

However, as SMR drives seem to stabilise around having a fixed zone size
(with a possible exemption of the last zone to cover left-overs)
I'd be fine a replace this with a single 'zone_size' attribute which
could be set to eg '-1' for drives which indeed would implement variable
zone sizes.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
