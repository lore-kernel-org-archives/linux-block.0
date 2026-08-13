Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BB48A8C6
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638303; cv=pass; b=fuPFJbNlJ/E8Dv7uRo4xmQj5yD+BNLtUhY5KBa3649helvKcSdONBKfjB7k6usB+a8HxfD1VW5MYOj90Qs0hLUtUlaBfT0VCMBBv5jlDUoCgYBYj+DXphzawaSOnmd+VLytQHLDFB9GWjtQCwYgmbGXqjBM+rRKFrnFQnUtUdqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638303; c=relaxed/simple;
	bh=U2gO8HXUYu7UNRdDeVwuXqd4PSnS6zEV3nJs86kjuJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqBvvss2gA2DsONrCHanqcB0sUeowkLuq0oaSXNAAppfwGwKWyn5NvRT2wK5d9s8VdXaKLOEzjoLM51vitDjBr+DPocxdNQAyzln4kQINBOyluM46ZPl1/p7EeeYP42f4lzrlAkLYPEzkk0S7A9f0w4tKj9DDjtYbg1nQjRVDgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGHOT+W/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnYBfDw9; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGHOT+W/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnYBfDw9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786638299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDjRetmtu85IwRz4yKH8gCl8QTGFcjeWkycVMxdyxng=;
	b=UGHOT+W/CVE07gBw2iR7gDjcLuCt4xujnCGqkN5tiANpe+RBXH1dZNOaHk7MB2WFqiqJPi
	tGHBzpd9kDiBVm137obOADTyViItWyDLHTnOqPCpSLzZI9b4UWQU4T/k9q+rEtCVeW3WTJ
	UyKFI20ZPWtPUQgcupyDUF0tNUdCedI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Ork58H3eO9S-hmFcHCEQiw-1; Thu, 13 Aug 2026 12:24:58 -0400
X-MC-Unique: Ork58H3eO9S-hmFcHCEQiw-1
X-Mimecast-MFC-AGG-ID: Ork58H3eO9S-hmFcHCEQiw_1786638297
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495529a93f9so856375e9.3
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 09:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786638297; cv=none;
        d=google.com; s=arc-20260327;
        b=O8N/FI6MxrtdoqDIlEQuOh+/y8D4sz68QQ0filb7onr5OBUe5S8+wrxI1QVd+AHAmH
         vUf3XkoaX9tpea2gX59aPC60rnfq1g+2VYYfINgjUI86yUJf96D7bkZ40eoFlkRLTfg8
         YZ9Te7BxAL4YM2fD1s7LfgIFy94oqHECOAzRNXhrLOLOqY95JityfbUph3HP2tfMaoF4
         5v65Ujoc5tEYQO/7G71CNyDqs2gEunNPGm8Cwn79nevMDp/Pf5XYYbmtS9l6lz/ogoFj
         ulkX0TZIgzhaqQ1MdxXonjz/N3yEQ2rj3QcIYDdzNO9OI52irg/O0HTu3wXrgITN/t2C
         E3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xDjRetmtu85IwRz4yKH8gCl8QTGFcjeWkycVMxdyxng=;
        fh=Mv1S8J1pzH0Zyw7WIflmHLY8WxFLduDmR38kHFXgBfs=;
        b=IYxbKe8sMVkqpZUclnca4L5xlFnB3WZ0qKUeqPeRvIa/0M3TkXYyLcca1Q4bUUlKL0
         eOAx/vnVCuTAHo27MTkqShmL1Ij7G7pJFhgNxf+lKToPRKR5F2jkLiAOS6EYMKAroEOK
         Aqn6a+mqh5kd5Cj8LZgYkf6HCrpnZJnqFf7gfoupkD0N98AJtQCovl4pzJXWuQbxS/GP
         LnVTpY5eaRSydHjvtEZ893LFm/QGOU3Km4RNL/l8SehoLk7DrXpJt6Qwv8UYX+Lt70fy
         7j1NzmyzUX0IBIz1L0E0ENPZRld05sjlkwnTzzgSCv8s7zuJ2ZuHx7SJT+euviOmMedY
         yDLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786638297; x=1787243097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDjRetmtu85IwRz4yKH8gCl8QTGFcjeWkycVMxdyxng=;
        b=XnYBfDw9XUqnBjt9mLo05gFmxUxDVGQ9W9joyfagSLq68iBuItjlLCBnp2lQIwWINw
         GTMjiSVO0tmcQzfIUpqP+lofJGQ7vqQmPZTn1mA47CfcyVKvlJKFw59gXCUJv54EHEuq
         aTKqXQ96XMekmJV5sqVuWa0S2YEIQ3WxpCWsc/6We4wDTW2qE41Ck/vyrpUxOutp/qJ2
         uwRfUiFaeO+5v8PeQvi9MO01myxS4v3vnayOk8BxbAPmj5QfaM+zBMtGHuRHbijlDq+K
         IwMKwhAeu5tEM6v/V+wi35f6TTiwzr5GZmXHlyOD2YStKjzWGLvWfI3Ra7Xu1cZKUjmT
         k0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786638297; x=1787243097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDjRetmtu85IwRz4yKH8gCl8QTGFcjeWkycVMxdyxng=;
        b=rhFxiA1A5itJXcfmgAreREwMGJIC/acUPVq1J3WPPn4ng0bKjY9QrgSornpL3L0qeW
         +HOGQqSizfSVNvhCPNygoBnyOcgTfms+R4je50xJ8IBUO9wMozI3+tK8TJuOeaBPWxNC
         IqU8LR/CqDOoi8eCeqo5ub7thLUnTH9x54hWGh1E+Vn+eAeE2l0lC3/tXkNM/vV6x5k3
         slQex4r0wQWxoHugK3mYhiXNHzzkwZ7uYet71+9o7nuaVxFXwgFbKe2pOEasr16m+U3Z
         ipr1yNBdCwSKnLjM8XykvG9ZZZkbl8B6tHtVWosCutoGwEP8ZqpyY3j9Vzm9fyglc7D4
         X78A==
X-Forwarded-Encrypted: i=1; AHgh+Rr40OupvL+HQIphRws/4RBrgf1ICpPpUclu/y84SR6+2bGF141d2If5o+9RWc6J0RAE3ENaLHxk0legyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WNI6xxajZHKfUIFbvvSXyp/IR+OjocheeqauGOe1TAmipNHp
	zLpORfUHRjcAEHfwAiolzbQMX5MYTBKS2Ap893JvDFAvgcFirvbuF1PTj3RUO9et0wLjJ25WPnk
	nsTYhzGFIemfellrjWyD8sX/opZ20r3pSyYYqUmLrSxK1oEBJli5PszhLr8avABSSaGvR4SProO
	+FLOJrjVTzmL61LEIxy0dRv8nhvJZUaJaJwfZmXg8=
X-Gm-Gg: AR+sD11YN1ZtrOQClZ0YNnT8UBb6u2jR9ut9Zsx+pyU5qm1bJM2L34/+GYDpUmoh5rm
	OVBOxnbGRvS76pYnzJNdr2KvhZj1lfOGGE79EtNxQULnrV75QjiWWatUksIUvIbwcyLHgr7mIK9
	hVJSv5zg6zgK5W9PA/MFALFEQv2H66KL7/LqNNH+ZJrXEWWhUrj96A6LyAnVZ9O6m6tRMu1vSnU
	cKs/lR9/0Dcu0vLZQ==
X-Received: by 2002:a05:600c:4692:b0:499:781e:25fc with SMTP id 5b1f17b1804b1-499821c5a55mr85647625e9.3.1786638296954;
        Thu, 13 Aug 2026 09:24:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4692:b0:499:781e:25fc with SMTP id
 5b1f17b1804b1-499821c5a55mr85646715e9.3.1786638296566; Thu, 13 Aug 2026
 09:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812181300.3712426-1-jtaubepe@redhat.com> <CO6PR18MB450084465A542D9DF1E46C51AFDB2@CO6PR18MB4500.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB450084465A542D9DF1E46C51AFDB2@CO6PR18MB4500.namprd18.prod.outlook.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Thu, 13 Aug 2026 12:24:45 -0400
X-Gm-Features: AUfX_mxnzn0QQGs-cPHrzMNrM17HgyUB_gFx1iWfyyxeIkP3fWyqO39kLk3cHho
Message-ID: <CADRr4bceLLuu4KRf7X+P6aNyBtK+TGrBDKd4T5Uuw5DaM-9gXg@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 00/13] nvme-fc: FPIN link integrity handling
To: Nilesh Javali <njavali@marvell.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"GR-QLogic-Storage-Upstream@marvell.com" <GR-QLogic-Storage-Upstream@marvell.com>, Hannes Reinecke <hare@suse.de>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, John Meneghini <jmeneghi@redhat.com>, 
	Bryan Gurney <bgurney@redhat.com>, Chris Leech <cleech@redhat.com>, 
	"Ewan D . Milne" <emilne@redhat.com>, 
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 12:54=E2=80=AFAM Nilesh Javali <njavali@marvell.com=
> wrote:
>
>
> From: Jesse Taube <jtaubepe@redhat.com>
> Sent: Wednesday, August 12, 2026 11:43 PM
> To: linux-scsi@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.o=
rg>; Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@kernel.dk>; Christo=
ph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; Justin Tee <just=
in.tee@broadcom.com>; Naresh Gottumukkala <nareshgottumukkala83@gmail.com>;=
 Paul Ely <paul.ely@broadcom.com>; Chaitanya Kulkarni <kch@nvidia.com>; Jam=
es E.J. Bottomley <James.Bottomley@HansenPartnership.com>; Martin K. Peters=
en <martin.petersen@oracle.com>; Nilesh Javali <njavali@marvell.com>; GR-QL=
ogic-Storage-Upstream@marvell.com; Hannes Reinecke <hare@suse.de>; Jesse Ta=
ube <jtaubepe@redhat.com>; Gustavo A. R. Silva <gustavoars@kernel.org>; Joh=
n Meneghini <jmeneghi@redhat.com>; Bryan Gurney <bgurney@redhat.com>; Chris=
 Leech <cleech@redhat.com>; Ewan D . Milne <emilne@redhat.com>; shinichiro.=
kawasaki@wdc.com; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; =
linux-nvme@lists.infradead.org; linux-block@vger.kernel.org
> Subject: [EXTERNAL] [PATCH 00/13] nvme-fc: FPIN link integrity handling
>
> FPIN LI (link integrity) messages are received when the attached fabric d=
etects hardware errors. In response to these messages I/O should be directe=
d away from the affected ports, and only used as a last resort. This patch =
adds a new controller
> ZjQcmQRYFpfptBannerStart
> Prioritize security for external emails:
> Confirm sender and content safety before clicking links or opening attach=
ments
>   https://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!te3Z1f8UYnTa1E=
-duf06bvZlnS-1FrR2Jkcx8WQcjCWqN2c_NKqyKXnJoJcD4hWMKkUnua_-glfm3m67hWRah9Kf0=
UTKp-APm3w$  =E2=80=8C
>
>
> ZjQcmQRYFpfptBannerEnd
> FPIN LI (link integrity) messages are received when the attached fabric
> detects hardware errors. In response to these messages I/O should be
> directed away from the affected ports, and only used as a last resort.
> This patch adds a new controller flag 'NVME_CTRL_MARGINAL' which will be
> checked during multipath path selection, causing the path to be skipped
> when checking for paths. If no other paths are available the 'marginal'
> paths are considered for path selection.
>
> The testing for this patch set was performed by Bryan Gurney, using the
> process outlined by John Meneghini's presentation at LSFMM 2024, where
> the fibre channel switch sends an FPIN notification on a specific switch
> port, and the following is checked on the initiator:
>
> 1. The controllers corresponding to the paths on the port that has
> received the notification are showing a set NVME_CTRL_MARGINAL flag.
>
>    \
>     +- nvme4 fc traddr=3Dc,host_traddr=3De live optimized
>     +- nvme5 fc traddr=3D8,host_traddr=3De live non-optimized
>     +- nvme8 fc traddr=3De,host_traddr=3Df marginal optimized
>     +- nvme9 fc traddr=3Da,host_traddr=3Df marginal non-optimized
>
> 2. The I/O statistics of the test namespace show no I/O activity on the
> controllers with NVME_CTRL_MARGINAL set.
>
>    Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>    nvme4c4n1         0.00         0.00         0.00         0.00
>    nvme4c5n1     25001.00         0.00        97.66         0.00
>    nvme4c9n1     25000.00         0.00        97.66         0.00
>    nvme4n1       50011.00         0.00       195.36         0.00
>
>
>    Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>    nvme4c4n1         0.00         0.00         0.00         0.00
>    nvme4c5n1     48360.00         0.00       188.91         0.00
>    nvme4c9n1      1642.00         0.00         6.41         0.00
>    nvme4n1       49981.00         0.00       195.24         0.00
>
>
>    Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>    nvme4c4n1         0.00         0.00         0.00         0.00
>    nvme4c5n1     50001.00         0.00       195.32         0.00
>    nvme4c9n1         0.00         0.00         0.00         0.00
>    nvme4n1       50016.00         0.00       195.38         0.00
>
> Link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__people.redha=
t.com_jmeneghi_LSFMM-5F2024_LSFMM-5F2024-5FNVMe-5FCancel-5Fand-5FFPIN.pdf&d=
=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7My57sfPbDDcMFJyBD6G2keJbhsQZV7WIf=
8SjB-450c&m=3DViZhyiiF6nkaVXOE1PpaKWe2JBe94gTGHA24wKzPP99uuwXoNoSYqcE55NQRq=
t6_&s=3D0jhQeJW2swbeXGSnNtXSHqXkNX1eVjXmU7QSm6m2IpU&e=3D
>
> Testing has been performed by sending all FPIN LI ELS messages from the
> switch to the Host and verifying the proper nvme multi-pathing behavior
> is effected with each of the eight different FPIN link integrity events.
> Results were verified with iostat and with the nvme list-subsys command.
>
> These tests were run with all scenarios including where there were only
> non-optimized paths available, and where all paths were
> marginal/degraded. All multi-path io-policies were tested including:
> numa, round-robin and queue-depth. When all paths on the host are
> marginal/degraded, I/O continues on the optimized path that was most
> recently non-marginal.  If both of the optimized paths are down, I/O
> properly continues on one of the marginal/degraded non-optimized paths.
>
> Testing has been complete with both Broadcom (lpfc) and Marvell (qla2xx)
> 32GB HBAs.  Both HBAs successfully complete all tests.
>
> For a complete description of the tests that were run, please see
> bugzilla 220329.
>
> To test the path handeling use:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_linux-2=
Dblktests_blktests_pull_264&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7My57=
sfPbDDcMFJyBD6G2keJbhsQZV7WIf8SjB-450c&m=3DViZhyiiF6nkaVXOE1PpaKWe2JBe94gTG=
HA24wKzPP99uuwXoNoSYqcE55NQRqt6_&s=3DXKJyyaOO9_UGG6uH5fv88U7bAke7X9H5Xz0qa3=
9qubs&e=3D
> or
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_li=
nux-2Dnvme_20260812174503.3705830-2D1-2Djtaubepe-40redhat.com_&d=3DDwIDAg&c=
=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7My57sfPbDDcMFJyBD6G2keJbhsQZV7WIf8SjB-450c&m=
=3DViZhyiiF6nkaVXOE1PpaKWe2JBe94gTGHA24wKzPP99uuwXoNoSYqcE55NQRqt6_&s=3DqPf=
emamvpsdH9yAG-9CRAILRyvMrzEaa_xjIaJTo1Ds&e=3D
>
> To test the full set including FPIN decoding use:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_johnmen=
eghini_fpin-5Fli-5Ftests&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7My57sfP=
bDDcMFJyBD6G2keJbhsQZV7WIf8SjB-450c&m=3DViZhyiiF6nkaVXOE1PpaKWe2JBe94gTGHA2=
4wKzPP99uuwXoNoSYqcE55NQRqt6_&s=3DSzJUICtyPkmr7xYyCu6_gZb5itPn8MZRQm4z0Zoew=
ak&e=3D
>
> Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.k=
ernel.org_show-5Fbug.cgi-3Fid-3D220329&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtf=
Q&r=3D7My57sfPbDDcMFJyBD6G2keJbhsQZV7WIf8SjB-450c&m=3DViZhyiiF6nkaVXOE1PpaK=
We2JBe94gTGHA24wKzPP99uuwXoNoSYqcE55NQRqt6_&s=3DYbu1spaO4qBWAVWu7hq8KHIP73x=
HRmGPfJCrZVoqacY&e=3D
>
> New refactored implementation enables administrators to manually control
> port marginal states via sysfs. For example:
>
> # Set remote port to marginal state
> echo "Marginal" > /sys/class/fc_remote_ports/rport-4:0-1/port_state
>
> # Clear marginal state (set to online)
> echo "Online" > /sys/class/fc_remote_ports/rport-4:0-1/port_state
>
> Changes to the original submission:
> - Changed flag name to 'marginal'
> - Do not block marginal path; influence path selection instead
>   to de-prioritize marginal paths
>
> Changes to v2:
> - Split off driver-specific modifications
> - Introduce 'union fc_tlv_desc' to avoid casts
>
> Changes to v3:
> - Include reviews from Justin Tee
> - Split marginal path handling patch
>
> Changes to v4:
> - Change 'u8' to '__u8' on fc_tlv_desc to fix a failure to build
> - Print 'marginal' instead of 'live' in the state of controllers
>   when they are marginal
>
> Changes to v5:
> - Minor spelling corrections to patch descriptions
>
> Changes to v6:
> - No code changes; added note about additional testing
>
> Changes to v7:
> - Split nvme core marginal flag addition into its own patch
> - Add patch for queue_depth marginal path support
>
> Changes to v8:
> - Rebased patch series to nvme-6.17.
> - Added patch from Gustavo Silva, "scsi: qla2xxx: Fix memcpy field-spanni=
ng
>   write issue", which resolves the field-spanning write issue
> - We decided to leave the "marginal" state as is, because the transport
>   driver uses the term "marginal".
>
> Changes to v9:
> - Rebased patch series to nvme-6.18.
> - Refactor and fix a patch from Gustavo Silva, "scsi: qla2xxx: Fix 2 memc=
py
>   field-spanning write issue", which resolves the field-spanning write
>   issue.
>   This new version of Gustavo's patch fixes a bug found in testing.
>
> [NJ:] I could not find this qla2xxx fix in this series. Am I missing some=
thing.
> This fix is certainly required to avoid few call traces reported, as disc=
ussed here,
> https://lore.kernel.org/linux-nvme/97526d45-ec7d-48a0-bdc6-659f75839f53@e=
mbeddedor.com/#t

You fix:
Commit 7db93e3c580d ("scsi: qla2xxx: Enhance purex_entry handling for
29xx series")
fixes the issue.

I forgot to mention it in the change log for V11. i will include it in
the change log for V12.

Thanks,
Jesse Taube

>
> Thanks,
> Nilesh
>

