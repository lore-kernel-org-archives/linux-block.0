Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8329A1
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452673; cv=pass; b=TyffoR97U62tyW9EnTGyPNP8BiqTTltd8xEUmyFN0vIkk99scH2q6tgzLmTckp4LtXfwdMlJR/qgv7dVIGeoQWv8Ybloy0hdKHpsnr1z2EhAhjRbToe2ljN3cT2Wxiu4h1IYCHov3vhScZzgQok67VhbtAWDiv5b6U0nNYWFPDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452673; c=relaxed/simple;
	bh=WpzeHBLSY+xjuvTaXlTYLto5hsZOV2p2fQ6GadC9+lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reI98VSw75wN05hHe30E9ybNvje9qmPuuwcMcFAP46DUN41HRERiS3uMRa0ZtwAZV3NU6sV060Dq0czZaTzPVHEbh7G4/yvObR2T4Tmq0w2bJn9KAO8AKUUO6PTVbLFPmVl7+QOvKoRRg4LE72V61625Zp9+xPN2ufh3jEoSZDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAwliWU+; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAwliWU+"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233e05c77bso418508c88.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 10:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769452671; cv=none;
        d=google.com; s=arc-20240605;
        b=Uq7/W3Ap9enUaT1KV1ahrFbfdKMlwE9938lf+2tV3ybLRFdWmK4uSKo/nkiSUFAqmy
         e3ysDE8mkbZnoxsqQihdyf+cXSl8GBJp/lKnayPLdprd8wcV3dYDUmPt3DsougmPB9xJ
         xgIeeA4O0vs8pJoO43pSsAIIrcI1rbsmzopKeRJSUw6Ua9noMOSBtbu596xwoHJWaiui
         GFo80uukNgPSGr1dRGIFheP32XGqp+ZkbaHNYGjWADVVzd+SiMGQlQH7uA+OxXykX82p
         9N1yquIZFDgExvH6MztmyFdpph1PwMFqppCB2A6cEW4N3lp3vQXP7JR7S8RpR7oVuNnC
         vWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WpzeHBLSY+xjuvTaXlTYLto5hsZOV2p2fQ6GadC9+lI=;
        fh=bUBtUmSrQf+m9rzzIGvYeEhBNSCA/dUPM7RPn0kK/iI=;
        b=BWjyyoAD3Fkum+9H0qWysfTDULFVVMtBnoarNORbmoS8eqGmABHN7wE5tba+J5xqUr
         Bf/PCbcp4sRxuWw720ffPpkSQ5A1RDvsm4v3PMQGDnSh/JuFsnkYITak6Whj8ydyX5r7
         mjpn9mGRUbmaxSMmRzWrwVIc7MyMteiPTFn+eXfIjXpcbmxs5PhTtODspwunLyNuzWJ+
         VXlzA7jMqYkfIzBfqkS7dkMxDtnapIcYlunLoRiIF5nO4oEOhqARignW9ulojOB5uSNK
         XpzARm9JdwUHEmp1NcHXRffNWQ+3YY5aFbEW3hbF7/kqw164OHYLtPqRkXVh97RJbTin
         /xzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769452671; x=1770057471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpzeHBLSY+xjuvTaXlTYLto5hsZOV2p2fQ6GadC9+lI=;
        b=DAwliWU+My4OAqdqsJI2kCUXR8pJnuClvl+3HXeqUu9nvuTPKT9AmkJI+Ynb1uyRiO
         rQxTMdtL6ajLwxvvYDTkUX8dxWIKllmqh3KorzKlCPeWbgDniCOdWctGQ5JF5v9wDASL
         kkieUS9aM6gl2dc/qEmleGaU97xH9Yz0HplEGqWEAx3JrkWp8JRTix6wWSUIfvMjghbd
         stB+vGU5uR1ZkBsS6gxs84WsLBRIjErtIrMhUzpg3Lje8LxyX6o5JU06CwWS+u8UVkS+
         jjrRbhgd5CI+gDMAT8N0GVCwg/5Fi2/xsPnDeslyienqniYX1zyW4dvdyP8QM0zPjHSi
         OX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769452671; x=1770057471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WpzeHBLSY+xjuvTaXlTYLto5hsZOV2p2fQ6GadC9+lI=;
        b=NheXAz0S6qQBBp+PpEcLHmI3sHuBD1PWav/S83DQNW5jLFm5RHrEOSeyGbaWUXv3Bz
         TKErQRdevGL4JQreeuTiuXI28qcioVhQiw9uGOSsopWwYEnvit7KHMbxGc3BV3QDcurm
         S5hvbe6Zl2tsg1Kqv5PvPxQQ2CEuOId9GoekMXwcdfniQIp3FDwIFdki34fryA5T1tik
         6EXtkO9G6aM8WZhwzBl97vQABdVn21rMEESbx6VuZQyJvtmMEM0zexWbmjn0ADB+KzQ5
         Ge/9zVhQ0XRMrx2tPJUqJdJ+9k86hjQReiaxbrh79gEA+XuPz5f8IKWNjLgqW1aNbMgU
         E6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVUdPydL6VccIhPCdkPlvGTYy86dZNwr/i5DtjaGIv8XgMt898Tde0X0wYQv4CQ7DEWHzBI61v1y95xXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzth9rdG4+tsYEVIFyMwZvPYPxDMFTVPn/plRr9QE9LcIZEXceM
	A6FHGKVelSfxcUIlOxUPMXi00SCVgHHoX7kHqbSKHEr9okVmHrkgVaHOy8wJ2sTE47JI6iP7kYW
	no2DKC+h5MTdkUfdodKEgegsa+KEnS4U=
X-Gm-Gg: AZuq6aJY4oK365czx0OzQ89D3qmLxh3JKGm0yyvtBXvaYd92ShDK7hgeKysyeprhnQg
	jX3Uy0T61njohytODZUv0g4knGOjqVHGUClhgyCdeg3Vi8HCGWkS1q3aUhny+I95TnD1bIQ6pDp
	N/BTosajdKQoND9uf0YxFHGLT+8RHKJw98FSAJhmCo0yHJmP2lNPFUfgboMGG/rg570gJvROCGJ
	Orl3jzAxonH0+sQcSsrznektJAvlTCp5+erSO4a0j1X4g7QCparyGJ/OuTr/MZISrF4pUC4YPv2
	avnzZt3T6Nrju/GzFl6/v2vqVFhsVLBD1STnYYbxuQhpfa+vbMamT/KAKRJd0bQb5IYgolraacj
	9u8QKjSPBtFYd
X-Received: by 2002:a05:7300:fd05:b0:2b0:4a1a:657 with SMTP id
 5a478bee46e88-2b764827c0amr1293844eec.8.1769452670619; Mon, 26 Jan 2026
 10:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123172007.136873-1-gary@garyguo.net> <795qzMaJiv4J6R3ywJGnvJsSEz1Oo9XKAOGd3DhpySquL_JrdxisQmp0NP1EPBFuvBshX5Tcb-ld4_Pu2nfPFQ==@protonmail.internalid>
 <20260123172007.136873-3-gary@garyguo.net> <87wm14rzz9.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87wm14rzz9.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 19:37:38 +0100
X-Gm-Features: AZwV_QjWY_AZnJS2reuCtbB7R_Ey3d630g_c6F3LtKnM0bZ51qre9qmk1Xtwcpg
Message-ID: <CANiq72nLrYzc0Pt0COX+gpQUgwgF+nO4jYiawdW8MATm_b666g@mail.gmail.com>
Subject: Re: [PATCH 2/3] block: rnull: remove imports available via prelude
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 7:27=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>

Is this for Jens or do you want me to pick it up?

Thanks!

Cheers,
Miguel
