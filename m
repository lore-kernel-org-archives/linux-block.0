Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96B1A841B
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368633; cv=none; b=QKugpSqAqb4ujieWLVXgBOcAO/idCaGwNfyPyuBpnqehWdVqMKLui5MU3v7DbFJMFULs3kV0q5BbB+4oyKBqKoX6cAeldbSvCR6+bMuWjrAOM5wZpyVKp8T21Ap6cKhGtV6gn93V1anhInUPBWDfPzm++/r1DP6zfL8ON/mFl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368633; c=relaxed/simple;
	bh=FoCj2wZOlXVxbzmakk66/ByIg+IO7g/sdeHyyuKYxGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QhMa67rzIoWqfYwkArC9zJzrihnQ1TbGsBeRQJjXxXc33mXuGKMTIENYa7VQetdEoQpnLEKaM8OlOHEpojGxzM61QLnkpOeoMXCsIQ4szuyP2oUY1r5qplxkDm3Ld/LbK/vdW2uAPUSQivXNIF5mDQC+3BhW0K5BDRg5Kmsrrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a5v2f1Qj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a5v2f1Qj"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43675b1155bso2913025e9.2
        for <linux-block@vger.kernel.org>; Wed, 08 Jan 2025 12:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736368630; x=1736973430; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FoCj2wZOlXVxbzmakk66/ByIg+IO7g/sdeHyyuKYxGk=;
        b=a5v2f1Qjlv7sXERPbvwTfQllF495bmCI2WrCKpb14lZMNX3RRzERWYMuI3XFZPgn+f
         RJSEdgLK533LqwQ+mVcR995KeeX8ReBN96u1DaxV3XcmSo3KfnauAno/tE1sJSmKHoYq
         fschmxWuto6htjh+gEmqAECIYiKQE6QyrVc1pyNl64dBCzGpFBcO2IDDkhRJdBidQ+XM
         KoUNuRDgJYQVfDm0cDLCc9ed4CcFbbZZcdBOcdhZBME4PCVg1DEBEdBdS3RomOgA0kYb
         GnyPdKKBvKD/ys8j/RJpjN1vC5zS2SHFavtBw6hVELpL8xBE7taG9qbjxiw2ZcBhE1ka
         5DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736368630; x=1736973430;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoCj2wZOlXVxbzmakk66/ByIg+IO7g/sdeHyyuKYxGk=;
        b=WPhy62Aum1+Au3C189CmgIFG3TCiIguV5wAd7rxLGRZgYqaPhBDkvVWjUFkdsHpnyt
         wkmGMo6OOS7Gcnr40A8OjkE4fjNob0g+UFfvBpJzNmy76LzttkpYurVSccfL5MeCaOCF
         D+/O4p9kJhyUxw7t+6cPmcX28Yy/dP7bwaeBLuTwEoT6eHKOUXVjUozB/aseaQCtYdu8
         22fFaGeku+IKbJVr+Qd//o8UXeyv5n8UFXaIlxXoIQvOFypyRb8sFNjvHzSyMToRurbT
         yRC/neRmiJB5x6Te3cBy2u3ZRCK0HTwReGCnjm9ZNORzYq7fjy7iSkQ5mng+035av9cW
         S0Uw==
X-Gm-Message-State: AOJu0YzFEdChU4jKnKp23Ibb39f0+b2HG0XpNWddsNOcZk1eomHkK8xa
	bcOSiuvdeS+Xxck63Y8p/FNyQUwUDEas2ipdTsJ3vVhB0gCyrbuVYXz/gRMaFO4=
X-Gm-Gg: ASbGnct2WvHQhVhgqwFoZe4fSXq6wdHU+t+4Yo63pKx41PQ+MP2uV4uSpwNPLFI74Oz
	Vhg6ZDkT3my5iADvRtGM7rbKebuNRCkWh9VGMG8AFtwPMnTjoZP3vLr4zS0b4H+kMZtRQXhyqkZ
	LdTc4YZNL4yQ8ncJOIm8hiBUE3tmF7V2RkbYbxk0V/eMXj64GjwAsUvCZLmLqX7/c9mOAaFk3Y5
	gUUIYjebhzFlemAv6gSVUIZOwb4wD9yojouB5vWFo8WXo5JibvAejlGpC6YMYCCNdEvXXmVlu/k
	p54njtpQ6uN1Ph7gmzyT3/dFS7WOaxWTbRrT/x9t53BzVXcOd2bWpCV6VcP3vGzJS87bargmqp0
	A8COsvQyjUX9I
X-Google-Smtp-Source: AGHT+IHpnnqDyxLOQ/nirgjGGOdJ/ZH339XOXDS+je7JQQB/3fm1iDtTpuu0EuN1RG6e4kTXU5QFmQ==
X-Received: by 2002:a05:600c:4e0b:b0:434:a7e3:db5c with SMTP id 5b1f17b1804b1-436e26aeeeemr34671985e9.11.1736368629554;
        Wed, 08 Jan 2025 12:37:09 -0800 (PST)
Received: from ?IPv6:2003:de:3746:4600:ac00:378:25cc:9f2c? (p200300de37464600ac00037825cc9f2c.dip0.t-ipconnect.de. [2003:de:3746:4600:ac00:378:25cc:9f2c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8475cesm53429771f8f.57.2025.01.08.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 12:37:09 -0800 (PST)
Message-ID: <f693d9e8e0ece410ea6a8d1cfc26945286178231.camel@suse.com>
Subject: Re: [PATCH blktests] nvme/053: provide time extension alternative
From: Martin Wilck <martin.wilck@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>, shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, patches@lists.linux.dev,
 gost.dev@samsung.com
Date: Wed, 08 Jan 2025 21:37:07 +0100
In-Reply-To: <20241218111340.3912034-1-mcgrof@kernel.org>
References: <20241218111340.3912034-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-18 at 03:13 -0800, Luis Chamberlain wrote:
> I get this failure when I run this test:
>=20
> awk: ...rescan.awk:2: warning: The time extension is obsolete.
> Use the timex extension from gawkextlib
>=20
> I can't find this extension either, so just use systime() and
> use system(sleep) for the sleep command.

While I'm ok with Shinshiro's propsal for working around this issue, I
wonder which gawk version you are using? In the history of gawk, I can
see that the deprecation of the "time" extension (gawk 5.2.0) was taken
back in gawk 5.2.2:

c3c6419 ("Make the time extension deprecated.")
6e195e4 ("Undeprecate the time extension, add strptime, update tests
and doc.")

The NEWS file says "The time extension is no longer deprecated. The
strptime() function from gawkextlib's timex extension has been added to
it."

Regards,
Martin

