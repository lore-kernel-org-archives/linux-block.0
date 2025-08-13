Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5132F28F2
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078054; cv=none; b=hYyoSqX1pBfSFt/NismGAz+SexZ+CyxNMlhOF7bgl3j4ZqCv8mhT4IOVTv3jBrJpOngco8n7e7F2F9dn3T6oaTNkcpRlgKwacqAlZPWaV9ycnPWvTZkOgFbJM8SAWKtt+W7PVaDaXcJKUFYZbqI5D5n8hWRWp0CTrDSnhlPUR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078054; c=relaxed/simple;
	bh=r+ogwS6zQjeSBn776QngYtEOAsPLDZQTut3nCmVuv68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsDR81khe6g+Ud2pcBV8SNqfwIr2WKF5/nOfB+QwHj5Ldkd4cIc4/aHl0roFV8Z8hPejYVzTHOYh2Uud3PrG9KuoKjX+nXuZQMVg25PtRecw203Q/SjEhRTtGomdYa67meTgebFDUpqfjiQkn4CMYDl5T+fgQyFBzbWPASj8a5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=IyetmWSN; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="IyetmWSN"
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 457591006D69
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:10:40 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 457591006D69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755078040; bh=r+ogwS6zQjeSBn776QngYtEOAsPLDZQTut3nCmVuv68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyetmWSNH5XjFey2IDSYKVEigxqx3gDpa5bLTgukMmsNTuq/baR797OGe64wgJvnh
	 86PusgIi7sM06AAnsdRRKyr/U6ucVcXi9rzCpArAXE9GlkEKGjBrG6MvvMQmQXfPH/
	 yIPX9lEaowlan08qPAikjA8vxKeYQydRq4fJlUJg=
Received: (qmail 14228 invoked by uid 510); 13 Aug 2025 15:10:40 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.40343 secs; 13 Aug 2025 15:10:40 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 13 Aug 2025 15:10:36 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 0093E3414ED;
	Wed, 13 Aug 2025 15:10:36 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 49F7F1E8132B;
	Wed, 13 Aug 2025 15:10:35 +0530 (IST)
Date: Wed, 13 Aug 2025 15:10:30 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Docs: admin-guide: Correct spelling mistake
Message-ID: <aJxdjoALgYkPJ61Y@bhairav-test.ee.iitb.ac.in>
References: <20250813071837.668613-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813071837.668613-1-karanja99erick@gmail.com>

On Wed, Aug 13, 2025 at 10:18:36AM +0300, Erick Karanja wrote:
> Fix spelling mistake directoy to directory
 Fix spelling mistake directoy --> directory

> 
> Reported-by: codespell
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  Documentation/admin-guide/blockdev/zoned_loop.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
> index 9c7aa3b482f3..64dcfde7450a 100644
> --- a/Documentation/admin-guide/blockdev/zoned_loop.rst
> +++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
> @@ -79,7 +79,7 @@ zone_capacity_mb   Device zone capacity (must always be equal to or lower than
>                     the zone size. Default: zone size.
>  conv_zones         Total number of conventioanl zones starting from sector 0.
>                     Default: 8.
> -base_dir           Path to the base directoy where to create the directory
> +base_dir           Path to the base directory where to create the directory
>                     containing the zone files of the device.
>                     Default=/var/local/zloop.
>                     The device directory containing the zone files is always
> -- 
> 2.43.0
> 
> 
