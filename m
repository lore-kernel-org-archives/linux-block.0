Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A0EEC3
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131416; cv=pass; b=ZElcagniIPT7lPevjm838dPMgDe1kCxCXqoc+E8lsqayI1/I/8HLH1U1bafg0mmDLlBRHC/jI6B6oIrxv19fpGGmJIIpgz9EYzG0XvI1mum28UJ7p9ugJfIGFPv7f2DhgD2Gur5MzGJtNF3AaSNY86PgMLL6Tn32rbwdO5nYavg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131416; c=relaxed/simple;
	bh=E1P/jKeLTITaEg2uiRxu51q4eC03n7OutGh+U5SKGJY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mYMXkYGox+qpvm7sfdzgFJ5+YE7kPPMBguPGvvZ21zg8LkS5tsRCncgYOZ049rlFl4lRK/5Nk+4WzhajJV8aCztJ7nQFlMO9xOzNO51idHF3/IVX2+53LQhy+LgHFtYkdH0HSCsrZxFkgL37mCz/Z8TrVETaM1ZWGkrUZ5+y35c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BdtBHhcC; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BdtBHhcC"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso1058575e87.1
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 07:10:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770131413; cv=none;
        d=google.com; s=arc-20240605;
        b=NTu0AXp8xjGJ8RkU5AvZ9XXhtUo7BtrxSjBdg+emLDk7cIL2HKERXs5qYlF7oqoq+R
         CBYZD7M8HMwlGEY1RxNlA7CtFNJQJA/+Lxm7ydiTUqgX4lIINYBsCWKVJeGDdW8cb8TG
         pnnY+YppbmYV4zVk+5WWEHDsqo4/NBmK6yshJA+j+DebSFlHfFUlwjrId1HgyMAeZWL8
         6RvSoLi8sZbNgX7jZUIBqhVfuW9MLe7oEFfVi4aPTqAAITdAMxViqk37MFKHwb/Kz7uS
         fPCehND7QulVajZFw5U7obH2KwZCxh/PHL15BHtsGCVP5JzwhW9OPl6jFzEkgznj/G5x
         6Ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=E1P/jKeLTITaEg2uiRxu51q4eC03n7OutGh+U5SKGJY=;
        fh=zbR7/JQB0OO/r08Oqode0BC6DW2Jyxc2MeTsLLsdB6c=;
        b=LFGeCX414ImIiQSLF/8bDFbQdgH5Sz1rN1sRedi9lT5AZKllnXuipNO4l51a/eREl3
         VYAi+TXX03G3/J/C8I8DU8ExjBmq/PerQ2jF4vNHTs4ZW/C+onLAtrZAMrI2Ag68ePYX
         JnZtVerAx87afsWl5Nr+rVVC6QIWtZxbGZy/vJjVriep4d2o0kAqUKnrI0Bt0jaChFEb
         RVOYNE7x3RnSDgp3u1WsobrC0ZWoif2haYfuBhy/kostJSgdVuE6twTYOcPEbTWS2MKY
         0ObkeeIohEvnN7ZwhyTki1LerWhqBx6eCKDA+FO8InHfasDz3/efC8kHlg5bVTtKYIO0
         wQrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1770131413; x=1770736213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E1P/jKeLTITaEg2uiRxu51q4eC03n7OutGh+U5SKGJY=;
        b=BdtBHhcCkn+7yYZUGa3PdDokrx8V3pm1wuenTw68179+LvQoQ3kcjcaJRowhp/7RaP
         o81I5UX2A3R01uAHcqoj3jgi681xf+trmNPWa7ffqflZTQWoBwTK+dnEFPcver7+VoWK
         PvQtvCIMxi+yYp3MZuKHRKYkF/foZgt9+j14cxDwCQaqtEWfq2ce8Ga69V7FZyTV2W93
         xwnEXY1QnZFAoqIgOFbkJmS+djiVFJ5Nu48zpRp2bgSx1ZxTFXNyddm82sjIbGL5OxO4
         dsBVljvf8wWXJTNj9Hyy9vRtVDBXCpVFkvKR4LHB3rti/0VkizD15XH4sc2DXoSPr29d
         jydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770131413; x=1770736213;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1P/jKeLTITaEg2uiRxu51q4eC03n7OutGh+U5SKGJY=;
        b=siRB9/wuQ6QosSkRV70v/nPQJ5TP1d9Db+BhYPbL8CEPL56yyEzmoMelFnoDAJrLkt
         DJ6cT9FliBn0wByjLVasNSkbTgM4d58vDjLrElOFusW/5kizK8XDg/fFqeB+NXt+Tb6H
         ZzAKQZbKHzAP7dIPAK2bmsiVr9sdGIGByNkwD+//f60fHG/7hLtBizZOMhBBIaAVc+xs
         jSBt0nUi79azXjG5GaCLPfPi+LuInLC0Gj3Dd3lcJcxtdXz09Zszyur98nQgfD3DLals
         TD2nzi4/aZNIsngH5bcUaZKclAjDyQo6IFz4XlmuIjQZjvDx8LOzKnoSPzaLZ/QbErP4
         x52w==
X-Forwarded-Encrypted: i=1; AJvYcCXUxc6O8kbK8H04BDdPJ2ZqG2klp3WTVTXJW5E56BPzgby+BtsokIFrZfhGDkEtRsKbDp4etuJGVmkspw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9v9rn9Sdjxoc7wvwJdE7PaJvd3TV+HFIYJTkbMKfqN/fqbnp6
	S7p359VAO78ec8QEYJ6yMBywNIE6NbTXy4goxLqjOLQD56Z0DUilwXSUKlvOyO+skkSDyVeY7He
	F5n3eAo2OTkxcJKinDNVx21enJknlRP8ZpDaL1Lu88w==
X-Gm-Gg: AZuq6aIcMuAI3LBabrTgzuGkcYVHxzOj3wQaFZ39QumXdFpSDFwNIn89Co8cAQ1mT7X
	tFV03mUDAzuGxeHoALXLwNNr+sB4ryizqUpDNhDfLBCp9dQmuDL17I54PdaTz1d/jEIUxC1qYXx
	9xbM/JWfEie3lZWTUBv3mRnCG+bKD9HD4iMCjnTxqGnlvbvyA1np4nPEerBeV08ToTFG2NfS5ib
	nM9u5KQ+WDrbTDnfAwFW31wunzVP15z0oawv8/7AqVz1pTfhjigthnDvQJx/KAZF/R2lDCOih7g
	RMZTHMRX+IN/FrqYNEFb3a2sVgFBSou9LAaHhtqFnwWhC5Y4zdL3J+pGZaMWRKTuaH4=
X-Received: by 2002:ac2:51d3:0:b0:59b:ad4c:a0dc with SMTP id
 2adb3069b0e04-59e31700921mr1290774e87.15.1770131412756; Tue, 03 Feb 2026
 07:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 3 Feb 2026 16:09:59 +0100
X-Gm-Features: AZwV_QgUI9j_N4lfZ_aafA4jh_DFhv8FDMCk-hFt8OyjXbdkqVCdgN8qrpHOOm0
Message-ID: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] A block level, active-active replication solution
To: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Cc: Jia Li <jia.li@ionos.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

We are working on a pair of kernel modules which would offer a new
replication solution in the Linux kernel. It would be a block level,
active-active replication solution for RDMA transport.

The existing block level replication solution in the Linux kernel is
DRBD, which is an active-passive solution. The data replication in
DRBD happens through 2 network hops.

An active-active solution which one can build is by exporting block
devices, either through NVMeOF or RNBD/RTRS, over the network, and
then creating a raid1 device over it. It would provide a single hop
replication solution, but the synchronization during a degraded state
goes through 2 hops.

The proposed solution would provide an active-active single hop
replication, and a single hop synchronization (directly between
storage nodes) in case of a degraded state.

The first kernel module is Reliable Multicast on top of RTRS (RMR),
which uses the existing RTRS kernel module in the RDMA subsystem. RMR
works in a client-server architecture, with the server module residing
on the storage nodes. RMR uses the transport ulp RTRS to guarantee
delivery of IO to a group of hosts; And also provides data recovery if
one host in the group misses some IOs. The data recovery is handled by
the RMR server module, directly between the storage nodes.

The second one is BRMR, which is a network block device over RMR. BRMR
provides mirroring functionality and supports replacement of disks.

The proposed solution tracks dirty IOs through a dirty map, and has
internal mechanisms to prevent data corruption in case of crashes,
similar to the activity log in DRBD.

We would like to present the idea and internal workings of the
solution, and also discuss design and some benchmarking results
(comparison with RAID1 over RNBD/NVMeOF devices, or DRBD) during
LSF/MM/BPF. We also want to get feedback, and potentially get more
people involved in the project.

(BRMR/RMR are in-development modules, and we plan to push them to
GitHub or somewhere else before the LSF/MM/BPF summit)

Regards
- Haris
