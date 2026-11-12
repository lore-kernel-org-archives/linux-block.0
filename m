Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491658;
	b=bKltXu7Uibx+BzwnzyyL3Wfsty9OEi/vQlrHme81c1ebpqiwoxi67iUVy1HoiZ6rCF8Z
	 zgWMpd04Ivd6vnV3LeJEwpAfN2A5Kzec0j3FhopTkTc5BanwyhAXHLCTfZFL+BE3OkeEh
	 D4ql263DjngHjU8VDwsDwTOHI5+yZ0f7cOxSRDkb4r9drruD0sVyx8c1c0WZu6DzJKsF3
	 9LJslS9+vVENjmr7RIW1lm+Go++BQMe/0Tlg6UbwsnRQceN34DJOIj5ThcplbmKMmNiAd
	 Y1xhmXHgUPfTFUFeE0rTv31OSqXQWE7c17MXF3PR6lua2KirWL/IcxmAzwyX56AKRvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491658;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=V2Cw9EYPNQimUM6HO6P9J807rf481yKoikMQBbiJAII=;
	b=UwbfxHX/q0rwHqbjk0OGmJM21vj5/M8rSANFHw88BU/s1Fje83ei3cy74g1guVGqnOWI
	 LLeYhPN2Ge74BT+v62hfWw4XFXYfQseO76awzc4rxVuKmy+MA6q7v0bMbblLys03xLYyB
	 oog5B6tXcKDXVQEHnk5IuoQWgamVhaO2ng+bVAUnqa2dedBmDWBmt5i4zde35HRC7HVxf
	 JTFyqFgC1JDIpL4qSL6CW6egPqUXBSreT0iPgrioL/Mlkakaa5BwyKK4/uKtsKm0j+rnT
	 6C4KjEBabXybYyYGV3Ow1tx4RYY2uUVYjvEyBwKQuxUdr/CP8KpQ5mGUgyIMLl1TASw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072B606A330;
	Thu, 12 Nov 2026 13:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A072B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B50C968D05; Thu, 12 Nov 2026 14:54:13 +0100 (CET)
Date: Thu, 12 Nov 2026 14:54:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v4 2/3] block: allow error injection rules to delay bios
Message-ID: <20261112135413.GB24065@lst.de>
References: <20261111215838.103356-1-haris.iqbal@linux.dev> <20261111215838.103356-3-haris.iqbal@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111215838.103356-3-haris.iqbal@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

This looks fine to me, although the two Sashiko comments look valid
and should be addressed.

