Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C093093CF
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 06:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715253; cv=pass; b=sHoyzk7KoiVr9lP9tdn4qU9Qn0SGrMsT5rmqI+mztcyWSi/L3qTLmheFq9A29ZZ26Wo2o1PfR30b8rYp1ctaw00IzUNuXgmpPqbJMcF0Lgme/BIXXli5ROzgoASmDSgQ/fKPPH/cHsHzobW+/YLcP4BTC0nTck6dRzKUJcE+pz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715253; c=relaxed/simple;
	bh=x8VrKS6HIWkkDV3g81RAsAaRpE1iHQtCFFxkhbl+5wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJfCPZri2jmbIUUJPst05jtiF6ftM1NABzkk7ZjAbUg6q4YNprZ7ZqUOzcHjxAi+M/zWEsi4O7hOGe5QuG2d+KnWqBifCgZHZlR+tn0/BOBgELI2R00kBQCqdN74cN5rd08Q/79lwJfjDcQ1FHDCvZdzxfaCw210UOWDlPNb6Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K6R8D0oW; arc=pass smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K6R8D0oW"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso549998a91.2
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 23:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775715251; x=1776320051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8VrKS6HIWkkDV3g81RAsAaRpE1iHQtCFFxkhbl+5wY=;
        b=Xq04DgHwWGolUwdR6leopRwE2RamTHAvdyneUGFI/FC6wrrxcgFTDsOHBDmRHMrnql
         /UoPbs9IvsqGD42Wk4oPZd41+akL2rRaIZyUupD3ZvyzWEPXXqdTTICit+oKAF2IQBqA
         gY1bXZm16xRxyU5L/eItquyfCGPdUUPWAQqI3wWeQGjVCA+Xi865jE9kZJ89UndmaJEU
         PE/kGy9z2y0NBUpG5DpCj5WHj/WVYfK+PgObJ+7RFqkwuytmqR0ey/BvdyJ1j48F9yhx
         d9Osri4X0SWXDENSnP9/3zsEB7sydBQUdybRTLkCLfI7e5XF/wCua4D0FhMfHw94rx9s
         y7RQ==
X-Forwarded-Encrypted: i=2; AJvYcCV25cH941kXzVWLky0/Qq3jcjxoupgwklU5HV69HTnXXnSEZsfSV+fjzi7jNllYZRbGOv6nf2ee9Eu9gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTr9nH4Z9N7/hRt0z3XJ1Z7W4UeyP1u7hLqkMibkqY38zoVL3o
	GrGka8h6Wskha0i8hn4bt1DwczPlbMNNzD8/MANbAE8eCjZyr2lY7vvqU1HAgHabrbjTgWarAJr
	LPlXePpFUqNwYvzIokQk1OXULVuh0/poNPEIwj4Paq/nE9YRxsLmea8Z7RgRLpaFH3ZV3v/lcNf
	X1kyUMaJ6tH/5jOs36KcMB6f7XkV8DPVVTiG5YMiDZ3Hn11houHaWT5fOSwoeCKN7k+CIpCRrvY
	Xv2TTLlnxtRd+F3Lw==
X-Gm-Gg: AeBDietJ/jE1/dIFEMaSVm2EM8BOiGZSgSZ//V2gwrRsTeWeUu5KXWwV4vzGb1kmfuz
	IEvumWXYdVJz153PWcSqlKsYY8kBZTsGi0rInjRsWEF4JEMrNWuHinn08/6S+7/OdXtMZJh0KzF
	z9QaKkfHD8GYf5qhmu2WDNc3odmNXySZBaGkWvyD29l1vD0EDIgc7oVJKxd7klnSniX0uUUuKW0
	9ebzjckrlXoPfOthpwI+pKs4/lkjCV9S29IkjSnUUQOdQlk7uQzIAjlkTv8jyTrD/6BBvsHqgWv
	BOc87HfBILZRqPHJOCyGOX4NHsg0xd+HDU3jFPUqCiLOra7Jz5Aem9Pio8U8bYw9EXR6v2ig8vm
	3HNTkY4bl3f8qpkqoUnSAdKoOZQJgcc8SbPr6Ar4tu5dfPgHrP2ozrL6doiewBpuHinb7ei3wOt
	uIf1VuJ23k65L9XK4uNoKODW6lkj2su98ZlxFBHHnnIedaAQr8VFQ9YU5R
X-Received: by 2002:a17:903:2ec7:b0:2b0:4554:9c24 with SMTP id d9443c01a7336-2b2817a20e9mr253695255ad.32.1775715251323;
        Wed, 08 Apr 2026 23:14:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b2748a189bsm14795435ad.25.2026.04.08.23.14.10
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2026 23:14:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-59e11fb980fso334422e87.2
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 23:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775715249; cv=none;
        d=google.com; s=arc-20240605;
        b=lE5VuDaI9ekj4q1ggpY28+B0GzBgsyUPxnUNNdt+Kzg/lXizLbcVPrn0fXxUcAVVdj
         ljDPvWIG3kY96RL+v0gaGHo5gBV1ykMZsE8yq8fOv6PRtPIrgZhvqHckVO871+jRgdOU
         lMCy2vbHke/F1VCK0hrQ6LOHWDnqxRtgN2ZKBg+dQTmbJV7A7DGbVHykkMRuqxYzYnpi
         bmND1kk5XaW5CUe51LySjkrUtQIdhqeRm4zORntLNk6iQBTY7zSSfKIaRItaRnXBHm2J
         bT4mesAUTeaa1L7qxFAvG8axDNk+s/QjDMIcKTlh6Ulpzhy70JWAAPEl5zH2RNVdYF1S
         X6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x8VrKS6HIWkkDV3g81RAsAaRpE1iHQtCFFxkhbl+5wY=;
        fh=Ex3I4MDQhhEiuZqq63WIlcpibNQ21K5I0T3iT+0ch98=;
        b=hdhew/H8PvR3hvSqU2Z/gcn9O59elTpnyRDxbJ7eARfIHmg1+NemfHq+5aSIMsG8it
         OFM19mhMZZwhRYGowWVbigAdZFF8laQVbbE/eOqxxeQWn4bchkZfymszSp1rx2ARpoAN
         gTiyTHCmYEawRHT9cIKjFxt0GSPDblKXcjxn/sTYXa9wSJI59st4dcI9oaekhTRK0Oqk
         ckpz37A0ACzpxW4tOmk02WtfnKWax9qz5b1i9uJ5JMrLjNFtXMMhO+phETYLA5Y5gVAa
         /gQWDFU6kovdGNL1QpoVc4MEoHGPk4I1Vb0yyUdpQSVvPTqZoi5ypQL8FrtjRnvxumr+
         f8QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775715249; x=1776320049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x8VrKS6HIWkkDV3g81RAsAaRpE1iHQtCFFxkhbl+5wY=;
        b=K6R8D0oWZUHgp3bz8mjl0CxmvwJSybUsr4dNODN2Z+fMyvJDk6gbcdntUShkCWYIlR
         uri1NTWJAyoBlhUP+kOvhZDiM4cyuNVimf59QBtKngSRXujffzIXISEGaSpNfhFt/qGH
         OKkTdb8mcnoG66qgX4ksw494iwNQrTgjqg1bY=
X-Forwarded-Encrypted: i=1; AJvYcCXkJW0WBkcUxOwIut+7OKtOFpbBvq6Oc+1B+tIEcurnoTbQXhiLm7qGBhCd3eFtt+5OtHVr5s87VepGFg==@vger.kernel.org
X-Received: by 2002:a05:6512:3408:b0:5a3:d1d0:543d with SMTP id 2adb3069b0e04-5a3d1d055femr7496204e87.27.1775715248845;
        Wed, 08 Apr 2026 23:14:08 -0700 (PDT)
X-Received: by 2002:a05:6512:3408:b0:5a3:d1d0:543d with SMTP id
 2adb3069b0e04-5a3d1d055femr7496193e87.27.1775715248294; Wed, 08 Apr 2026
 23:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402074637.92417-1-sumit.saxena@broadcom.com>
 <20260402074637.92417-3-sumit.saxena@broadcom.com> <1d0d35fe-5e9d-44b7-9dcd-48289f9d9f53@acm.org>
In-Reply-To: <1d0d35fe-5e9d-44b7-9dcd-48289f9d9f53@acm.org>
From: Sumit Saxena <sumit.saxena@broadcom.com>
Date: Thu, 9 Apr 2026 11:43:42 +0530
X-Gm-Features: AQROBzCVjmKw5QHlEaQJks9SwSAuJmE0_wfvSzYRI3X6FIYaKsKaSGMO2VQiGqw
Message-ID: <CAL2rwxrU=pW9yhXGGh_Vd67OdSHp4tDGDxQtxcE=GZvfYb4j3w@mail.gmail.com>
Subject: Re: [PATCH 2/3] block: align nr_active_requests_shared_tags to avoid
 cache line contention
To: Bart Van Assche <bvanassche@acm.org>
Cc: martin.petersen@oracle.com, axboe@kernel.dk, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, 
	James Rizzo <james.rizzo@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a84c2f064f00ecb6"

--000000000000a84c2f064f00ecb6
Content-Type: text/plain; charset="UTF-8"

> A possible alternative is this patch that removes
> nr_active_requests_shared_tags:
>
> https://lore.kernel.org/linux-block/20240529213921.3166462-1-bvanassche@acm.org/
Sorry for the late reply. Let me test with your patch.

Thanks,
Sumit

--000000000000a84c2f064f00ecb6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ifscJ8gSasrjdgcsGC9lCyPXLwfNEU5C3Mbnua8OK6sTBpf6mvY88HW/6AoKiSpfo5jxCZQOm4Zz
oJWD5ea7ThJ2XdDk1rRtGUkwFgN9GRNfOoiIwkkA7EdEfV0eQkVqNgkqUyBSABXcduul2sd4/JQO
SsVmTdSKid7L6yZsqk5b3Xj+GMJwPdRfeKP2SRoys0SVnajc9Di+9Jy7uGKxxtb562egZauDFX/0
o0UgYfZrbwWfzJDYMLKzlrOD0M8yGkD8BnyIiVECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZc3VtaXQuc2F4ZW5hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQURSmmYGaiq6dg3CEvXQGHEXJF
8xwwDQYJKoZIhvcNAQELBQADggIBAAl0pcCjujKdwmgtiGl2naEY5wB4G601Kuu3032tR7wmgZLg
k+lg9fhAA0boPsi1FE1Pwb93YDBGr/naS/oQ9JglSMeEVzeRvCqjFS4FpouBAFHB77c8w3ZwJ3+t
FSRJW9SbW0DADBn5t8GAjv2aSm5vDorqFe9MKOYEe50yYDQEUAsEt5QkrLTcEx9ntvVb25MxI8vM
bdfqna+/TyCmFmnGAz58jiw5DxLn++6wMmAk0SeUEuMrAlRIyhte6BBSBQ5cL1P+DWSqQbm/pwCq
NhySSLNtTi2dKJvvg6Ax9au913KiJj6uZfPlh6/0kaVKM5GhIABUcm3c6g2qD7ITJxB/p1kjYKLa
hVrtrjK7000lHKTPFr6MWB4Ggx7yKQ9yIlPMKKF/Lj8FabYCqeM5ovG7kaK8FYXug5vjNjN0nedR
X3P8o+8aL6WFIAAAKm2DqZh3252Gcken8v5c+f0SXWSJFvemfFNgrJiQFnFVrOE5v7qwvM/KvVCA
dYm4Ph9QYI0sm+Xitx8MkdOJtq5mcPWowGi8UiCgkOidv4ki1SA0wptfquUhbfS9b2M3XUHCEIUX
4ECvIjR3f+E0NbBIfPccWfYUaDLvo2qhLYS3KQbhKdXcJ83ha17mbVNZbDDo9upNcLO/oPyDbCNF
J6UpXZmis1wnCynhK4kQfwFhW7H+MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMdI2Nfq/Vk8dzZMUnMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC5g+Ru
SZduGCUX3w1NFAYVk9axkv6EyptltRtbS+4ScDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA0MDkwNjE0MDlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBGrGCvsAps332SgXjzwKL7pCpKEsgql2mXacMG1Zd5
zayn32vq811td8yQXJX3WAlO1h+1Buj428LhdjjTkDB4+GZiABEY5QQCghrSFhicYbBE0HqEFDY2
JpJoTALqIoKck2JsBPZnmpUXaWuIZyiIZyLEa8546opemJdiNUnef1QCUftr2fDvjEI7OZaZIDIn
uHV7xUGghYVZxKXvlve0NRjMU7fEOcDCSfFGXi057KnYHK1uvORh9sIADXBn0tUlLbki2E6m5UKi
5g7XpSKJZCl91bAoX85IxDX1r0EWbb/JSoD1khmo+tNDqGDBDAGwWzw52hxEeF/nfnd4TJVJ
--000000000000a84c2f064f00ecb6--
