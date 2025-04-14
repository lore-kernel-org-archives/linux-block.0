Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BF1632CA
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744611557; cv=none; b=bdjaiLKbKsiN17IS/Vfutval8M1V70ZLfqbTHcXBARsH3tPOxAfKsc2lIZX32KPbwfnyZZ4hd+VP5wvrAovSW2KC0UZtOmqGPxeJ8DsxUsXwU/1Yj9NVCYgFRvMXDyDlJIA/QCXYNUuJDWHMd9/l1Mnq636VCoW8ch3SumEpoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744611557; c=relaxed/simple;
	bh=DxUqbpjmr/Lmmv3j3tcUhygaeweNzjr9xH8XtWeIj4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYTtBdndE/qmaiJrAUBGbQ/VjGW7NtD85XADV79z41+Kj4Ndx91YqaYFUiYYMouYmO+RFH1ctVXlu7Bh2Aad2agNDHYg8W0EBWIapWDySriwEe51+IpSpt3BIamImo6/PsMbPMYog0BYbGkB4r/WltuBnPf1DyGnS192knxSRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D98267373; Mon, 14 Apr 2025 08:19:10 +0200 (CEST)
Date: Mon, 14 Apr 2025 08:19:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/15] block: move blk_unregister_queue() &
 device_del() after freeze wait
Message-ID: <20250414061910.GA6673@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-8-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410133029.2487054-8-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 09:30:19PM +0800, Ming Lei wrote:
> Move blk_unregister_queue() & device_del() after freeze wait, and prepare
> for unifying elevator switch.
> 
> This way is just fine, since bdev has been unhashed at the beginning of
> del_gendisk(), both blk_unregister_queue() & device_del() are dealing
> with kobject & debugfs thing only.

While I believe this is the right thing to do, moving the freeze wait
caused issues in the past, so be careful.  Take a look at:

commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Sep 19 16:40:49 2022 +0200

    Revert "block: freeze the queue earlier in del_gendisk"

