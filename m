Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584793EA8D
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536480; cv=none; b=XG5eDDj8kCpvS4P0FVsPgOs2A6tHJRbBScTMOdElz4cdctwQHulzOEyu7rBKia7yKncc58H3M5mxN0xPP1lqRWdl6EcAIUf8H5fWgpWYyZISBdL3RohxU1bC+uoJ5TVGUgNX3BmPMFP/R0ZX7wczg29JMrsB4geC1KNIu85PMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536480; c=relaxed/simple;
	bh=aY+IUJXneh5Zur3ztVLw01Gd6XE1QUmvit1RFBlb+qU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgGggB+E2XLUgOKK6gvLKH4EUOH+vol/Y4QnDT6W3PjgT6WUL7zsWqj5T70gTjTSmwnyzShUCu05Lq09Q2RqF0yn8mXaZakx1gj87v2ecSkpAXEReHAqGwOJP75j1Unvkj0FMPIm+RM4R7BNQnkDJXsyhTFwRIyOw8ZSCKi+L94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.geov.name; spf=pass smtp.mailfrom=mail.geov.name; dkim=pass (2048-bit key) header.d=mail.geov.name header.i=@mail.geov.name header.b=n2u4FUjo; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.geov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.geov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.geov.name header.i=@mail.geov.name header.b="n2u4FUjo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.geov.name;
	s=protonmail; t=1758536469; x=1758795669;
	bh=aY+IUJXneh5Zur3ztVLw01Gd6XE1QUmvit1RFBlb+qU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=n2u4FUjoAvHDUM6S40GJe0rNA8jPeb6dJ0bhKYHtgpyTwTfexagt5tJee6AWybOyJ
	 72XiMjhZQPSnBWQW9IU5YkbTyfsBq7Uwzm/1y45O0JChjjFUWgkqgS8nY8I1KRpYJR
	 s+fPjZog2HOj3YguGNpNJSGigb2ffsdDgzTP+RqLq2kTdorZoECnvV194+xLuxdYBA
	 sw6MN7hhmmHcTXnd7lLDvR7p1vnoJw1o/v0164Lf9uz7Ms3o+CzwjD/KAYL+tWM9FH
	 lv71M0LLF8sU++wEqfU626RsSv+cClDvV2vo1AZnN9VA2gyIBwfZpI31oV95qYKFJd
	 raaUzV5A+WjNQ==
Date: Mon, 22 Sep 2025 10:21:05 +0000
To: Ming Lei <ming.lei@redhat.com>
From: Heorhi Valakhanovich <code@mail.geov.name>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [blk-mq] Kernel OOPS after usb drive surprise remove (bisected)
Message-ID: <kvwBrPBtwi3yb8Ox_OI2aMqhoPN8VIHckrkOh7niQCGnYLLEM6F9agKFotROOvEOgfHXCbNwaVvc0ueqY6fij1MeC8FL5Rzrb5xUoxEKZxI=@mail.geov.name>
In-Reply-To: <exBcRMEROg6miSMCdAJBfH3QsSlCgmAMkEgqyqK0S2Jjw6M8xQHfV2ejRumuPxFjnLOOT5z-tEoH9RUx3uEwt5T7gAtbTD-mBKccdZ_0xwo=@mail.geov.name>
References: <LmKwxMZhQ0h6bHWk_m7EMu4jDpbdcL0Z4gix3USIvS2sJpGZP1b_858GvxaDL6zwoGxrPIs-dT10NLxersJpxExsOOpJmyDh_fTOp97ZBYE=@mail.geov.name> <aL4jQG-_CeHxGPsU@fedora> <exBcRMEROg6miSMCdAJBfH3QsSlCgmAMkEgqyqK0S2Jjw6M8xQHfV2ejRumuPxFjnLOOT5z-tEoH9RUx3uEwt5T7gAtbTD-mBKccdZ_0xwo=@mail.geov.name>
Feedback-ID: 35076807:user:proton
X-Pm-Message-ID: ff7868f7b7399a08484f8f782d6e0ad78bb51f6a
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Monday, September 8th, 2025 at 14:53, Heorhi Valakhanovich <code@mail.ge=
ov.name> wrote:


> Thanks, it works (no crash) both ways: on top of original commmit and on =
top of v6.16.5

Should I live with manual patching till 6.18 or can we cherry pick it in 6.=
16.x ?
