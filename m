Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93BA349B04
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.135.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059393; cv=pass; b=n1XQ+6767g7zoFaoioqneKwa4QqkHleBqDeYgOOJMNgUei0FMYcgbCRosWi2TvXKU6Yk3AxInFfKHjJvPmS+SO3MN13lPlsX+o3ruqjLOZ4Yy+1AZdA2jJ+y7peMfn5jidxsi4qabwUBxmMoMRBlT40neTFgMIN/mOrcoWe17ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059393; c=relaxed/simple;
	bh=pDtBt1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzwjqhoTBS3aFWBT9+cR1snhvxhb6+t+xpLK2LAjeG20+MhhAStp7H+0zFTveBC3ke06te23eWBhGRs4YEOFvmiLQSdSo5d123Xm5RGrZ7M+J2yPzhdS3KQTVp3xCkHKttw2MHWOYHxh2AEV35QLpPD7CkwI1Cq99yshQnR17LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=nsrj0T6H; arc=pass smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="nsrj0T6H"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PMh4Nr1356842
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 17:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=pDtB
	t1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=; b=nsrj0T6HCt6fbehQN3aM
	mCW3EK4O0E/cM/Qy7KmXDptiP9Si3inQNFYIQScWj2MSnIVqk1bh6Ulf2iHVeiyG
	jOkKvI97CiUm8nbFeOE8ZSU6uEg9o21CwOqyT0zDJZaulMCy+81avk/zmfLBGPpH
	8zS2au6AvembXSGV6xYbFUcUF5MKKn8LhyrXp7Sf7rQ/fIjdSv01VirEFwBfgwbZ
	WZtyfKQt0yCgnh9sFSfrI9pnPAcpLvFJNu3YOATmrfvTleq6h4woEObun258q4a+
	8GChmZaWdoX1h6JiicGPjWZ3UYKC3TK6vAzSf9/FhEcslwYYazjWijqQesgqf0ma
	CA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4cj116dc43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 17:43:11 -0500 (EST)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-797b0076763so3361947b3.1
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 14:43:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772059391; cv=none;
        d=google.com; s=arc-20240605;
        b=Vozwy47uc7b7oBwghC4efmjuRVaTOXp1a21Ky0eCFcCuv9eIFyevRehU3+Z7quf3R9
         jbQD6nZVZ8WxwO0BpctbLfJPul2tCQOJxu81b7FfjAHGjsRifOs9jF99OuZrFGKU8hrm
         l30UNOObznE8eZtbbtqFc8EtZqUcD7aCwF7+SI/Y1zO2B1onhN4HKTgm0WIaGdbk/+dP
         SGNCp78H6DlwrJliQFDbaB9iaPsAk0OOpnR0kLE00gP7EDd8wSij09c743rs36TwkPB5
         tROKSduUx3RjZY+sL0/V55+Sc/Oj6m1NZO/0yWPXp0rZFANMrR7oXkOsoRQLqRoju4mQ
         UEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=pDtBt1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=;
        fh=EFvpIn/E1CSao7wP+ssS44Zu6i/6pxIrG1hO3/EgQgg=;
        b=BY1JPKEMTRU3V0XUgliniSReXddzLFN1mkJQ/7MLzQt5E/sCgVoY34xkTsgwC8jv0c
         5sQizK+cbZz/bPdsCAqhuHJryJFs7SewNUH4MkhkE244j3Vcr/PiZf1uhG6iQAMwL0fg
         MIHtGHEwuhMwP0z1dxdvDuceW74IRf5wsTAMt4+XwiAzX3hQc/0FbL4Mhro7fI67y2JY
         IHnGshhNWn/zVBpH0nyGb4kO/DWN8lR8onCWhnBtH+vpCaLKqomN2A0NhpUWBZeaS9bl
         84LndKBeN+tjDL4kCz4S8c37dKuBIY2defsTK96PgOF/ZLu0YK0QZ0Dm7dzdXwSLKojc
         778g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772059391; x=1772664191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDtBt1IUvockGTD9sAkNQUVYnZ2xavhQA7l7ZDVpiZY=;
        b=wh2HrfOMWpAi9aF/FkBhVo6PUI3OL+mmp3cqbebY33aazhuKJtR4VER6cV7ahuEgnl
         jeDvgyZqJlT5VXNrm9e2J5znqxNTLRpPsrJvyen0MKxFYLsP6qUAMqcNiWWKDQtzDNo/
         nb55qwOuoGT/4EjdvbmlQrI24LZRlHTTefLX6l733RVMqnfZ1HcU2jbcSuQtbxHtTVZ5
         SyEG2vcTFuliBRHXFDlixl7hTi/+73mNBKvRjJwRxr/LMHS0G8cdlH8sVOnc90G1P6Ab
         tbSOeXbk6Oj/ca02HcnToKrs7t+KVpAPRrWSMlJT4RIKbE+P7uSZAL9BoYBVXEFJJsTk
         9B9g==
X-Forwarded-Encrypted: i=1; AJvYcCUcZe9Xp67UFE/mIQ6WtnSSzXXlmCyOJ5++wNY8d2fSIFM1nWdJMY5q6rDu+ZsS4HrC4lB3z1WLc49sVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5IBv4XSZ2N/gvRrfz5JQgFIqDyteGwfCEW00yOhlHfh8zD4+L
	D4Y8QPSoHv3STnMveLfoBn0/Sf34KoETp+e/P/qmvqs9wRF0OXxtCfDsT0FTlLt8BN/6Jq9hw+w
	3GPmkhB66b1eSb5sedzmjQxkjNSHe5VxI3x2VXqRCeVhTSHqArcdem3turxlXk1N5PPoTwSOMgb
	u+Ra6TaT6fXGThP0If7u7p7lWgzxrHPU/wcSE=
X-Gm-Gg: ATEYQzx3U2lCNE/TwmNZfzmQYxTRKVxKRO37tr3kLI6J4JijLf+UV9e0o8kuv9JPj9Z
	xDXPmcCToDKSBKcIwuwiniAlJBNKPihVGEl4x4aHLnfuA53PKir4zzml0/49mJEntniEBiS+VVf
	Gh7fdH+H7cy+pod3HG8OCA3w9Ifv9i4J/vKKm6Cdd7n3rXWphuxfd/oMbKDzuizmeIu1qFXxeA9
	/+WZY25
X-Received: by 2002:a05:690c:4d8a:b0:794:e72a:f664 with SMTP id 00721157ae682-7986ff6368dmr23925737b3.60.1772059391043;
        Wed, 25 Feb 2026 14:43:11 -0800 (PST)
X-Received: by 2002:a05:690c:4d8a:b0:794:e72a:f664 with SMTP id
 00721157ae682-7986ff6368dmr23925517b3.60.1772059390662; Wed, 25 Feb 2026
 14:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu> <35866783-2312-4e31-904d-3746510eaf56@kernel.dk>
In-Reply-To: <35866783-2312-4e31-904d-3746510eaf56@kernel.dk>
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Feb 2026 17:42:59 -0500
X-Gm-Features: AaiRm51munUdTrnZZ7c7FkAWOz4juVf_xR9vg2o7Xlz46s_YpnQLMylaXhWKvd8
Message-ID: <CAKha_so5z7S6vD-betDLr=GREewxnWxeK9qawhZq8yKt=TD2XA@mail.gmail.com>
Subject: Re: [PATCH RFC] block: enable RWF_DONTCACHE for block devices
To: Jens Axboe <axboe@kernel.dk>
Cc: "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Bob Copeland <me@bobcopeland.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIxNyBTYWx0ZWRfX1MI0snNfIZW9
 7ay6rZ6iw3lEqIls47TTdCFgaWwsqEwUG5cVrSe5Dv7g4rrWmMeKoht7gOGGM3MTEF8HrFgvaIK
 6Id0XZX/FOe1x/+j4y9GJXaeFfHrRQypvima4BBjm3OoV4DtiR3s83wYt7gSowbH0bW2Czg2ckH
 RgoMej+odYh1nQK1eTPu6nUd4UeK6RrwbNuIvOBdii8A3Gwx0J+/dYqPMEfn/3Bb3IGU1U5W6iJ
 58iJ0jwLzI159z1kRB44m1qYYR+oNriLzx6PdVcoqmrKHbhLYzJPkX9C++CW86/zd0WzFTFljeU
 o/OjlaDdEEspXEmzY6TYKUnvPUSIFMUxgz/5kW0FW0JC6gfWACae5dMwmEjEwHVnQFPGnIsUCPi
 RsrebsvF8zfSuL5DnV4hTlNdFUUAMb6HJJdtRssjkITqqgiOhW/fis1uOXtifR/Lke1gXfnga2a
 xM4foAnIHGwQ0ILKLkw==
X-Authority-Analysis: v=2.4 cv=cYjfb3DM c=1 sm=1 tr=0 ts=699f7b00 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=79PYxaXUQd1wl-QFWJnA:22 a=VwQbUJbxAAAA:8 a=VNoZ5ujv9kIkDPz7VAoA:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: Zfd0O0W_t9uCe173NiP6IstX015SVnjb
X-Proofpoint-ORIG-GUID: Zfd0O0W_t9uCe173NiP6IstX015SVnjb
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=10
 impostorscore=10 adultscore=0 bulkscore=10 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250217

On Thu, Feb 19, 2026 at 10:24=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
> On 2/18/26 2:13 PM, Tal Zussman wrote:
> > Block device buffered reads and writes already pass through
> > filemap_read() and iomap_file_buffered_write() respectively, both of
> > which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device file=
s
> > by setting FOP_DONTCACHE in def_blk_fops.
> >
> > For CONFIG_BUFFER_HEAD paths, thread the kiocb through
> > block_write_begin() so that buffer_head-based I/O can use DONTCACHE
> > behavior as well. Callers without a kiocb context (e.g. nilfs2 recovery=
)
> > pass NULL, which preserves the existing behavior.
> >
> > This support is useful for databases that operate on raw block devices,
> > among other userspace applications.
>
> OOO right now so I'll take a real look when I'm back, but when I
> originally did this work, it's not the issue side that's the issue. It's
> the pruning done from completion context, and you need to ensure that's
> sane context for that (non-irq).

Thanks for taking a look! That was very helpful feedback.
I sent out a v2 hopefully addressing that here:
https://lore.kernel.org/lkml/20260225-blk-dontcache-v2-0-70e7ac4f7108@colum=
bia.edu/

> --
> Jens Axboe
