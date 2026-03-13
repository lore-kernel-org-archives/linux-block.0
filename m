Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8136164D
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426048; cv=pass; b=ftcPP891mdESfUOX+Gg9fdoGik1QELAElvVCDERs31EZVpWeJeobhGGThXcmvs3lcehlNJ7dK1YoXzMa3Br1ALoryYA6n/AHpwwvcYzPWMW9Lz2n4pCinyI5BfH8QMYsU7MwGtkE5QjwGqO+ojD6rIVI+XbPfjOMx7/JUyrELLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426048; c=relaxed/simple;
	bh=Yq+m5EkuVTFav9b9yhssRvAOb2WjokVpE0G8lUPWNNU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=miFbh4ZZAvjVjx5SkDgXOh8dfDvIiqKupldKqmmLSWdIrqPXu0xsRvQvNRWdyFmmqizqCrfJnyzV8ZQYRm2YKz9qEIGM2LSMKIA7CF1oeBpNT3882TZiAfPcFyJPtJh7AZ6n2qhxqDtGVM5SsU+k4mZvztDsneObuYyF+Rf61aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=ZGXsrjv9; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="ZGXsrjv9"
ARC-Seal: i=1; a=rsa-sha256; t=1773426021; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ipf5LanY0/eG5L3DQa1dy/X9swVW6gbGI5o47faP5jmuOXbAikUmhSmcjNvTKvVEWWZx52jrilaXLl/tVdKUwXsqymuYQbKWOeKNCLQy8NFOvfLaFkd58XTA2Y7kZ4eQYbPVIo6g0oVAVhLJvRE0hKG6B3x9pctpBsTrdJVZhjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773426021; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Yq+m5EkuVTFav9b9yhssRvAOb2WjokVpE0G8lUPWNNU=; 
	b=A2IMWvn2H46M0CUkBo7qS8Mu6Z/L7iZXz5JNf2wJXCNvRbELmoQH/Vv95hlSghGoFVq+oziXIBeLWoCZhoyRIftbTwZS2MxgTA0x0RtwjPDBnNVtF29hqV+79m1yTDj7wrSLNovUH0o+9cYFYY5UVE8d9XMgylY6ZfStKHoAglI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773426021;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Yq+m5EkuVTFav9b9yhssRvAOb2WjokVpE0G8lUPWNNU=;
	b=ZGXsrjv9JSzkG7yRpB7J5mU4Z179x8jDXAkGMuYwBHNSEb9XRhnDQm+y2V0YqTfS
	DlhLzRFfjhjwxdDvUQWq+gkAFIlJHakcyufv9RIKjPjXAio/OO6C9xhDKMVq+Zquq5J
	E0O5M5SD+gbcGnBXKSNQOoBNgdOQzFSOZ7rv5zhQ=
Received: by mx.zoho.eu with SMTPS id 1773426019865812.2359773353273;
	Fri, 13 Mar 2026 19:20:19 +0100 (CET)
Date: Fri, 13 Mar 2026 18:20:19 +0000
From: Josh Law <objecting@objecting.org>
To: Caleb Sander Mateos <csander@purestorage.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/7=5D_lib/iov=5Fiter=3A_fix_missing_allocat?=
 =?US-ASCII?Q?ion_failure_check_in_iov=5F?=
 =?US-ASCII?Q?iter=5Fextract=5Fbvec=5Fpages=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <CADUfDZo0L-ZkkSRwAumA5Tx2oevBg2qKKGM3uN3vpFKburqJ7g@mail.gmail.com>
References: <20260313181038.30018-1-objecting@objecting.org> <20260313181038.30018-2-objecting@objecting.org> <CADUfDZo0L-ZkkSRwAumA5Tx2oevBg2qKKGM3uN3vpFKburqJ7g@mail.gmail.com>
Message-ID: <90C824E0-8930-4D34-8615-B9B31D6C867D@objecting.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



>> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>
>Don't think you can object to the Developer=E2=80=99s Certificate of Orig=
in if
>you want your patches in the kernel=2E
>
>Best,
>Caleb


Hello Caleb, I have to ask, is this a joke? Or did I genuinely do somethin=
g wrong


V/R



Josh Law
