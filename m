Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B57B2EE617
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044024; cv=pass; b=Ev3pOCKfmxT5TBrWDqLVN1ruUV+2sLB536YL7hjv8y9SMvwRswvJ9K/1FQTSyHXKuz3vpu9e+EBRhJyXkMT3x06xGd7MIVG3brvr6tokTcirwYHsr0nT4yRYw8fxvxW2T9wheDsfYwdMi05XySKOluo2GGOSWzUp30B4KQhU0fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044024; c=relaxed/simple;
	bh=u3u4tA8JjvckzY3DyK+3fSioyieff9wJnK6/Ztx3dXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jITn92EfGigzl4gucXWpnMFevE5kUwW1UrrJNPkMFqtJR9rQVD9Nsq0AftsEimkUYBnjSkb2BOHepAlfP3wTdjmUPGGb/cu2JWG53fN0MjgEaWWfHeGlXZo8YCHGMw6TDWOQ3DHrkFZE8Yf7NMHY+jIbFOUMyKMIMTqB3BQdcKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oa/KH8+N; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oa/KH8+N"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5f5418c40daso1071681137.0
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 10:27:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772044021; cv=none;
        d=google.com; s=arc-20240605;
        b=j0l3rZxHIoBqcBXt+FMv+rfEYdicA5ZkuqX8TTCy7H9UmAMTMctrTC1E5C6eQwf1Hv
         pA2Z+uTMblP338ExjP2f9YEjHBTlsUaci6gr0vLFO+5uxOABQAsq3BVn5FP01ljEROfR
         wfXuzcJuAetHt+gaGAWgnypXtZeFZjF7vb+8GAHN1NljllFlKU7UOtzynbq3LzStwI+z
         Qlep1uzOILoHQwNXAesbEZcc84KLKRTt9W0av0lHvfxZO2ZoJTC5204S+QKlmPmIJZ57
         bi97v5zHQug3RVO8yvTn4DareOLEqV3v2n+NtfyBVzAi9Z0vgcLcptaVqSaoVxKzaf8Q
         zjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u3u4tA8JjvckzY3DyK+3fSioyieff9wJnK6/Ztx3dXU=;
        fh=1K/x1NY45DzZsntCYzqDd1BfqRtW6sJQrx26UTno+rk=;
        b=cNFWXbSBLodob7yf1XNS8mbX4PYwOmP8h7fY+tAsQOP/CAvXkqXqwHcoBujDTS/91J
         p89/KtwEkhgDALPXeA+mK1fk1u5bIdIBG5RJSYkEDpWludc7Xbhn8wbKu5m/H5EpEQCm
         e9CZHGB3J13vI+k3vVIb9q/4VN/vXky+kwXsyF02kM9tAViDSIXJlu6Wx05WEpJwmvz+
         F/0MVA+ksh5LwYru1L8Er7IR91GbCZJGJ5GoUBje8eWDNPYs+jT6uJv3GeoJom3ck4X+
         8BTHibcDH28Q2DyhTVTYRPc0liE9WPxrvExfyz225cVA8d3uE97xsvWzOtAUzvFrXx2J
         B8eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772044021; x=1772648821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3u4tA8JjvckzY3DyK+3fSioyieff9wJnK6/Ztx3dXU=;
        b=Oa/KH8+NBWUR148beR5eSglB20dzkoeNS+ziCdebR1TN4+4a8KDw3/8QwiefDp7T7k
         gyNlbs4foVQrXTvybFRVmzl53dGHgHa2yTubelFol6JLgObYjzoPXGdQykYT+mmfJ3Jv
         hnI01DaV4VNMFmtZkZhzy88tq9afCZcaCwpm8vKRN4+8SMgVdljtKMxUHzTYrRm+D6HV
         NEIF9OWxbCHF+z2B1X0AODDGq/gP8Eca3bzzHcPHexqJuRwKNKhN9Uw0PVuCdkA1KVbc
         u32dYEKoKQVruf9SJm6JgZ10LFGFwFW7ITSB2xZ6Tm03UdILVxJwTu71vLyGHl3NX3kZ
         jdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044021; x=1772648821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3u4tA8JjvckzY3DyK+3fSioyieff9wJnK6/Ztx3dXU=;
        b=v0N2sg5tKdvuy0e5HL0UuHDet+kh7saC/6DbeHXZ5AXH3rzaKTigzrzW+TfIh930wv
         Oh5aO+89423MvO4MhuM2KZ7AFaZQB33BwUiU9CA+rdyI2QaHwfS3nP7kIKZL3l2Vp0tJ
         kphGboT2/Npfo2c2FWHZeuTPW0sjOTootxC0DvOIDxUDp66g3F0NpeWPLVmPiRFK9N8E
         gV1pppl/xXjPm1rxZy618HaFG086XRKNN725ukK8hWGaA/6LK5NbjSSlUKfWnbq50jK0
         ytjMOaIyhojk9ExPAEE063U9ZhCXd5Yt3D3XK7ioJ75YBBSptDccDjOgyBIGjO8YN8Bc
         RfhA==
X-Forwarded-Encrypted: i=1; AJvYcCVU5ScjuGU+jRDDAyRE650nC57SnLtAJTFRbN6lBolZCszdiqVuoW9hx5XnZRHhKIOcRegOokdAJ8hBdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8iD8kUBGYaHeG5IEgVwaBJadbcSZaGABhVY/uZsxZk4L8M9M2
	GQiHe3smglAsuJ7HrEPXpUDRzPiKCrzu15xwOZWK1uOnQF94J6f1OCob29mX+3b9U85IF8BsPpN
	DQgKO4XiEb7cFHDgymEmS+RgtApacnnSXCpcXfyQ=
X-Gm-Gg: ATEYQzxQtPnqsTBefseSnk8nMPgMzolzT7V0Rwdyf7AwdovbH/ikWGm8s4Vv1CMXSfY
	4hbRQ0QF9BxKpLAA2VpQJdQwxva+BWsigo//eIKabvi82ozgnJHLcQHb6JASuqUynFLKX3U/hXS
	jwMBQNNg94dZxRZxhrfbdS/rkf9ET6qcOVylVrvZYypxm40ENqzpkgYVoA+7S1KSAda+RyXXXuI
	oc+dnL5CsGn02+v3GygYIsbm+gkvJRJkYKKkAaB07bUJuYotvoqsmPLcsEZMneJ/119fbDqne90
	ARym4YdkOTQttX3HC+yscWmfuVxoAGrly5VpZA/b6AoRdytS878/JQ9rwNk=
X-Received: by 2002:a05:6102:d93:b0:5f1:6fd7:ff14 with SMTP id
 ada2fe7eead31-5ff1cda8ae3mr21528137.1.1772044020680; Wed, 25 Feb 2026
 10:27:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219004940.2594201-1-morbo@google.com> <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
 <CAGG=3QXcA7et9LmZ+Cu8zn1yBXrPizL7BhYFvfFZpWA7aUR3xw@mail.gmail.com>
 <e3c0a209-56f7-4ac2-b089-e0600672cf25@flourine.local> <CAGG=3QVHKmZzL=C808qnigYDC1jiNSdwCODYdU6_2_yXSLAaSQ@mail.gmail.com>
 <466dd888-0910-4e39-8946-004ac7cd91d5@flourine.local>
In-Reply-To: <466dd888-0910-4e39-8946-004ac7cd91d5@flourine.local>
From: Bill Wendling <morbo@google.com>
Date: Wed, 25 Feb 2026 10:26:44 -0800
X-Gm-Features: AaiRm508r0jxzLx7RCyUqPQ2EELvQ2JzrSKvoI7z4jeTnorPzkDwgcSRt-MnogI
Message-ID: <CAGG=3QW22piyPN6ZCAEiNDHyrRg18OqqyYsy-2s6m2ois=Rorg@mail.gmail.com>
Subject: Re: [PATCH] blkdev: Annotate struct request_queue with __counted_by_ptr
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Kees Cook <kees@kernel.org>, Gogul Balakrishnan <bgogul@google.com>, 
	Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 12:55=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wr=
ote:
>
> On Mon, Feb 23, 2026 at 02:47:47PM -0800, Bill Wendling wrote:
> > Okay. I successfully ran the tests you indicated above and they passed.
>
> Ah great. Thanks a lot!
>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>

Daniel,

Could you please change "Gemini" to "CodeMender" in the patch commit
message? If you like, I can send a v2.

-bw
