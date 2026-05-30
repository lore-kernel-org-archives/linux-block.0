Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156EA2D978A
	for <linux-block@vger.kernel.org>; Sat, 30 May 2026 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780123782; cv=pass; b=KVJkDocb0ek7hEX8PBcIuMDJFwUjxqsYPepPENUzSTSVYhJy8oXdoaT1tNRG3hqvmtTMl0rZlxO9NxV5N0aQMKROfFydavZChbNBZEvRmm094t/xy5xXlBZ9K2PcT2Xyp6IlCc3sZd8OpcsFWKd1e8UKI2xxtMBrYjUm/z2qQIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780123782; c=relaxed/simple;
	bh=+bv70p8W2trpBn+eIa8q9/v0zYxELzQYi+51Y29g134=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzvMsq0ROeIOchBxn0vFGTlfDfaWbni0jCR387IlnI9IvWs9GW1JtgQOf1Sy1pJkofcVeNMOvqs0e4pw3bdedjAR1x+b63c+MWg4VfCSSWQCp4JI/fpMu90GTKtUhB1Hh8YqjwaMCtNPbTcGqMphbFUheWr76M/QXnCzof8drsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEs/6Os/; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEs/6Os/"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304d2c56402so169069eec.0
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 23:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780123780; cv=none;
        d=google.com; s=arc-20240605;
        b=BoolnTSZAviledgPirm6RbxlukMQsH0LFgRBRCazOUmEHa7CFZx8/B66MnnmBR1elM
         3uSrIs4P4o9lTwO/kanbVSQkavnhpAznRX8DkzLY+NZpLvYLoF9xLib8wu/wVVkoVPt7
         sWBgy3fhGV1t3y0uLSEwFE+iVM46kvpkhz5CBoxb7hQLiAK/cjUkpWTFaCBL70fHGBgt
         0VvkMj1mHMKT+6/PsrZFXF6DlKl3RUdjdhr4z7eGnDf1KxQ77TWaoWQ7EuyXK80aN62l
         cHwBu1JvZK8FODGGXfQVR43IZZFeA0VyjL04/6lvlyvM+ZHjVSWM4+en3UMaUrqLqPn8
         AIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+bv70p8W2trpBn+eIa8q9/v0zYxELzQYi+51Y29g134=;
        fh=Km9gBUjGQgowGuucuU+ETPayIZh0PmFaUaRkKB7KyuA=;
        b=OMOlKxtRpW77ngLmAobJVrwze2Ltb3ou8V6jBIcQblH/TkfUqe8DMgAtOtQ2B+sCL4
         5Yv+CDYQo4FUn+tscm1pntdzc+3Byshk2700EHEshXnSfmooGhq9Ln5kW3042jdScHHJ
         p1WlYQ2YcD98zejhKavDb8jPNtRJ60H3dohqphEg1eAnLHR9DApTH4IdEIHWTBz6HbND
         BqgOMfRLQ6R1jYspMm/IVfhORMl5m+Y2RPofZ6A80aCmRxMRM6BJbP547yjS++u8S9Qi
         r9elL4IzyXDb33WosOZmScB0lNQik1a7+HhTDUqeK3cyRxQpnL/pgTb7uFHjROoVI7me
         5GqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780123780; x=1780728580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bv70p8W2trpBn+eIa8q9/v0zYxELzQYi+51Y29g134=;
        b=pEs/6Os/go0lTdevvQXdDRRMN3OLPUhu1XAjq1gAxzq1DWFiwSlIaRcr0+ZSy6kbIG
         gjWWpy8VhGhJYPuPhhZ1VqTuIdynYLu3t4RwoMZ8fl6UImROujqlt8EwyQMUSlp6Q6Dy
         IvqvSOxpLMzxWUBcUZKuU7IQQl8CoC7s645JeXalgDkqnGkpCvEfObn23pedy0xtRLam
         VbNjWfj3Fy20mDquNNnqhzGhvf9S3SBfB6BuSj/R/NDrdht9c96rz45VuCZLOHYvFAcS
         4hqDqnhQXTEE4j/Ho4K6CmI9Ync6S9EUpGZnsTS1brwOGcP53zpwA1DddpdpO6hlvwhZ
         i6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780123780; x=1780728580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bv70p8W2trpBn+eIa8q9/v0zYxELzQYi+51Y29g134=;
        b=nbv1+h0Xkf0bTrwYO/z0uoh8F4o4ma4tqbmxYwNYld/K6cbA/7c9WgKOz91ZjirVIR
         MQzdkJ/aYAPcxYBX5/vNqQejcGS8eDqhubDuLUZ8lW0MCY0zdSWUK9UwtLSeRoIA+/ki
         lihzKsnePp4GifhH+KNiyp0/iqE49EnSLSRMae7xRRQ7FYDtydOAtMXDoV7/ZIuWHWF5
         +36SQbX4ZHeaOmMdJRK37nUd4+AcQjaVoxDNTUw8Ut6eXK0gry7UwoIzekIVXbtC1ezG
         OSndIgZ/WBTlZKCKk9EMWgezW3LS6CtP8PfkXLjq6iSTPeORIfoevfVU68uNL5u0E7u4
         d3zw==
X-Gm-Message-State: AOJu0YzUflu4o4/GSlY0cXS4ymosTSKb9OdZRlXAtgC2WM+QPpMCxIvE
	Sru8Yg95xMBkw2/bFafUy7kUABtQC4Pl9OC1R9OmEiJVrkx/FXwTMetx9ttll+/vB4c4Gzit/VK
	WQVKlgy0IeocPbpAfavdB6apEAmgduEg=
X-Gm-Gg: Acq92OF5lZKg6pjEz1mm/qieyeU2pyPb7ymQa6CAk4Je7BRBfpQ5TU0c73J3liOkEn0
	MV/eMIcPEGzCosDIc/dRQ/eCFdQwDTd+uNP4fM2VdqoiabLRY4/hpfne3o5RQz6ZKkbvIYH3fpI
	Lojs+Xevv7hp3yqv3Fz+xUDp7QWxJU6Zlz1SCzwDIbYvlBeL9l9oKq3H75oDqTrH9q8pD2yXHT8
	6D6SARCbidN7g8DWuYOLRDafGgfH7d/7FzAm6k1uz0L92ZKKvv6PhaDgCZGFfF4C30cy17EvGw0
	TzHhRk5X+S6jfNh+QOezuEfOIgyAG8jfClk4acPMrSSklCcyLm7Depsr9W1ORJyPkP8tIHwc8UX
	KHqSZKYwnyJMOBtQbTFiwWMxQDzIy77U1W6FQIlS9m3Ca
X-Received: by 2002:a05:7300:d508:b0:2e6:b55a:76ca with SMTP id
 5a478bee46e88-304fa30cb81mr629509eec.0.1780123780048; Fri, 29 May 2026
 23:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b70aff9a920cc42110fe5cf454c3099561863519.1780063368.git.royenheart@gmail.com>
In-Reply-To: <b70aff9a920cc42110fe5cf454c3099561863519.1780063368.git.royenheart@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 30 May 2026 08:49:27 +0200
X-Gm-Features: AVHnY4JaMKnB48pjUgiM-xBbzD76l6HeLJAfe-AlXb9vBmBPIAHovEQxKsA26aU
Message-ID: <CANiq72=cjwQfkdHs04naLLAo6=O3XCA3eON_gfq4OEqd9Bn1Tg@mail.gmail.com>
Subject: Re: [PATCH rust-fixes v3 1/1] rust: block: fix GenDisk cleanup paths
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, axboe@kernel.dk, tamird@kernel.org, 
	sunke@kylinos.cn, yuantan098@gmail.com, bird@lzu.edu.cn, royenheart@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 8:12=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> [PATCH rust-fixes v3 1/1] rust: block: fix GenDisk cleanup paths

I think block prefers to take these, but please let me know otherwise.

Cheers,
Miguel
