Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438246E01D;
	Mon, 21 Sep 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986558; cv=none; b=U/6IRb1GDmRiDx19gCww2Ldl1w19emxWqW9mRlBK1pRzBs6r3qzOb421lMt5vNgIyrU4K2xI4YKBRwfWsWr58lunEoq3Lpf7/AOcL3nhG7XzjbP8CpXRY/0FaCEKYYsFsBX/GCg20dZ7wncbiMlu7g8f4HJD5MQSV7APv9kXUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986558; c=relaxed/simple;
	bh=gg7GufPXHI3MjnU0puBbIoWyRAcap2K6AzjjzkOwcnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHUDTxSBmhan2sYsEqDzl6CRGrcym86xaF8nPZweCZIzf989iuWkQ0MRlys0nfRchYrJAq1GW+DJBMKYilPlIO7pGqdP8b352RWrrI6Cq3/k4WGv1DzhPkh+OwtUIQeafzK/tbpasInFxGllXGrbeCrCYC0VNncpyzolBk0UT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBYqwUfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBYqwUfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988E51F000FF;
	Mon, 21 Sep 2026 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986556;
	bh=gg7GufPXHI3MjnU0puBbIoWyRAcap2K6AzjjzkOwcnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lBYqwUfp2o9g1150tJrGhlc3WqQTYv+uLcFQffDsdbfYLAFQ650bOOkOyhVXlHIBj
	 PBEccpWIFxJSRMeteEyxz/RnvPCQGxqnMqZw4RyPWC47On2W2LeN4hexvgL+tbfvjw
	 N3xHJA1jETRbDy5A9amOy9kmEmDZt5/m/cjwGqhnILFJh95nDrqt1KBLbmGfYVue/v
	 zb6znGS4WA0e37Iq8Ay1cOndrDm6AbiCmKq4+w5cz9E3vknPjlUuK1bjCgPRYsTWl/
	 9KqjbGhfY+9ThTEJpziGyT6qBwB8rcxLol6nc9K9A3zBH+nKu3rTPfLn6/Uu3qnktJ
	 rZtHoTu1PFuxQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id D81921AC5363; Mon, 21 Sep 2026 11:29:13 +0100 (BST)
Date: Mon, 21 Sep 2026 12:29:13 +0200
From: Mark Brown <broonie@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Tao Cui <cui.tao@linux.dev>, linux-next@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	cuitao@kylinos.cn
Subject: Re: next-20260917 and next-20260918: merge of the block tree breaks
 all zoned devices
Message-ID: <arEG-YH7Q7ansx6o@sirena.co.uk>
References: <20260920125846.1806521-1-cui.tao@linux.dev>
 <20260920231226.771a0e21@canb.auug.org.au>
 <aq_5QycDLgQGCc86@sirena.org.uk>
 <d97685b3-f22c-4a27-a7d7-24b2ac7dfbe6@kernel.org>
 <7141040b-5a15-471f-9bbf-9a18bed864e7@linux.dev>
 <0ed54aa9-2cc6-4051-abe7-8144f39f6bed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SUF6pmeD9FlGm4tO"
Content-Disposition: inline
In-Reply-To: <0ed54aa9-2cc6-4051-abe7-8144f39f6bed@kernel.org>
X-Cookie: Too clever is dumb.


--SUF6pmeD9FlGm4tO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2026 at 11:31:11AM +0900, Damien Le Moal wrote:

> Mark, Attaching a v2 diff for corrected the conflict resolution. This is on top
> of the current linux-next.

I've replaced the patch with this one.

--SUF6pmeD9FlGm4tO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqxBvkACgkQJNaLcl1U
h9CU8wf/a0GBTq/Y0ThBWuEpezEY6ooGroVPWRUchrFWiga4hZ2jyKS+rNNJCY0d
yo5tV89FxXEZEv+JBo3oTL8mdUk4QREfN0wsFtpUP2tnWeiNVDCpE/HakVrsLxYS
euGjGxYuTG95gJjGrACbjHhZPb57KHOaFMmdjxhrzAXeEUHqLpS1d5wdrLag6NVp
Wg0GgtoPVHRZabG/uUkk9ABnHw5Ti40qLDaO/H6iinWaCA66DyCPGcZbG1oF27VO
VTRwNRUBBBeMNqTxA3zWVWIxA8G0Xba9oaoR90jy4djUzOctCh1jbRv/jHcqXol0
nIhkKI8fNW5IjwEA2hnlOnVG2+ag+w==
=mgsS
-----END PGP SIGNATURE-----

--SUF6pmeD9FlGm4tO--
