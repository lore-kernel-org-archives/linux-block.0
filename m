Return-Path: <linux-block-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:44723 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751476AbdBBUe4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 15:34:56 -0500
Subject: Re: [PATCH 22/24] ubifs: Convert to separately allocated bdi
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
References: <20170202173422.3240-1-jack@suse.cz>
 <20170202173422.3240-23-jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org
From: Richard Weinberger <richard@nod.at>
Message-ID: <26c70615-f98c-23a6-abb7-de675fb658b6@nod.at>
Date: Thu, 2 Feb 2017 21:34:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170202173422.3240-23-jack@suse.cz>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Jan,

Am 02.02.2017 um 18:34 schrieb Jan Kara:
> Allocate struct backing_dev_info separately instead of embedding it
> inside the superblock. This unifies handling of bdi among users.
> 
> CC: Richard Weinberger <richard@nod.at>
> CC: Artem Bityutskiy <dedekind1@gmail.com>
> CC: Adrian Hunter <adrian.hunter@intel.com>
> CC: linux-mtd@lists.infradead.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Is this series available at some git tree, please?

Thanks,
//richard
