Received: from mail108.out.titan.email (mail108.out.titan.email [44.210.203.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20B2F37
	for <linux-block@vger.kernel.org>; Sun,  9 Mar 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.210.203.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741537087; cv=none; b=Xnz7rZnS1k3WledLMLHYKXjSeRnZbXVEfWOBjat56/kyw7Lio6Ha2HdR7uEvszfVmBSAapfmsaerJQgGxqsn57FnyaApueeqpv1xH5O2/1ZESM2CFxVHRB8dyUhoPPuwUlWfyPz6f09YEZG7/ld32OOkLEKpdFDzU+6Wwsx7iYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741537087; c=relaxed/simple;
	bh=oH4wwJlTC8RywziiEnNdkwKpipiOGuOfib+M01mB0Dc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jBKfniw+XhxcJzpzIQWgjPVPmJI/hDikUhbosB/8jZlfpeIMdVwarzFzSdIj4+vF+tRKgvysGvTV7xWj4emYpx0HX4iMFsDx7OMKEZAU+78Z/2G01QyCSUVRAgYJJgrJoQddZQx+E1M/oz/82BZx7wV8FSTzAgx+BjmA1aJMwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=F+++zi2g; arc=none smtp.client-ip=44.210.203.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="F+++zi2g"
DKIM-Signature: a=rsa-sha256; bh=JsV29vf87lO68vdSl5Li1WxJXM9iyqC5aDWsbs6cej0=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=to:mime-version:in-reply-to:from:cc:message-id:references:subject:date:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1741536627; v=1;
	b=F+++zi2gB52tVzrlRcjmYFJ18U0pBDdfOw3GL8+hOd4HkcdLSIOG/bzE2H6VflRmy42FW2F+
	NNE72KavTC052Cx1NlKMqL59/zevAvKA4yrrx0fzxZBqqfDqwfOo0551cRFH9milY/U6X08nndg
	5h1UjpAmtsOcMlYiWlorPkKk=
Received: from smtpclient.apple (unknown [141.11.218.23])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id CE783E0105;
	Sun,  9 Mar 2025 16:10:25 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [bug report] badblocks: improve badblocks_check() for multiple
 ranges handling
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <c8e4f72d-7a9f-428d-a67b-41ddd4da8f2f@stanley.mountain>
Date: Mon, 10 Mar 2025 00:10:13 +0800
Cc: linux-block@vger.kernel.org,
 colyli@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1D2F256-1239-460E-BAE8-4C6C2459370F@coly.li>
References: <c8e4f72d-7a9f-428d-a67b-41ddd4da8f2f@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1741536627520804902.19601.6393682865750146538@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=IeV9WXqa c=1 sm=1 tr=0 ts=67cdbd73
	a=USBFZE4A2Ag4MGBBroF6Xg==:117 a=USBFZE4A2Ag4MGBBroF6Xg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=KKAkSRfTAAAA:8
	a=EAby17L36nNo1SpXxpYA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22



> 2025=E5=B9=B43=E6=9C=888=E6=97=A5 18:25=EF=BC=8CDan Carpenter =
<dan.carpenter@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hello Coly Li,
>=20
> Commit 3ea3354cb9f0 ("badblocks: improve badblocks_check() for
> multiple ranges handling") from Aug 12, 2023 (linux-next), leads to
> the following Smatch static checker warning:
>=20
> block/badblocks.c:1251 _badblocks_check()
> warn: unsigned 'sectors' is never less than zero.
>=20
> block/badblocks.c
>   1186 static int _badblocks_check(struct badblocks *bb, sector_t s, =
sector_t sectors,
>                                                                      =
^^^^^^^^^^^^^^^^
> sector_t is u64.

Hi Dan,


Thank you for the notice.


>=20
>   1187                             sector_t *first_bad, sector_t =
*bad_sectors)
>   1188 {
>   1189         int prev =3D -1, hint =3D -1, set =3D 0;
>   1190         struct badblocks_context bad;
>   1191         int unacked_badblocks =3D 0;
>   1192         int acked_badblocks =3D 0;
>   1193         u64 *p =3D bb->page;
>   1194         int len, rv;
>   1195=20
>   1196 re_check:
>   1197         bad.start =3D s;
>   1198         bad.len =3D sectors;
>   1199=20
>   1200         if (badblocks_empty(bb)) {
>   1201                 len =3D sectors;
>   1202                 goto update_sectors;
>   1203         }
>   1204=20
>   1205         prev =3D prev_badblocks(bb, &bad, hint);
>   1206=20
>   1207         /* start after all badblocks */
>   1208         if ((prev >=3D 0) &&
>   1209             ((prev + 1) >=3D bb->count) && !overlap_front(bb, =
prev, &bad)) {
>   1210                 len =3D sectors;
>   1211                 goto update_sectors;
>   1212         }
>   1213=20
>   1214         /* Overlapped with front badblocks record */
>   1215         if ((prev >=3D 0) && overlap_front(bb, prev, &bad)) {
>   1216                 if (BB_ACK(p[prev]))
>   1217                         acked_badblocks++;
>   1218                 else
>   1219                         unacked_badblocks++;
>   1220=20
>   1221                 if (BB_END(p[prev]) >=3D (s + sectors))
>   1222                         len =3D sectors;
>   1223                 else
>   1224                         len =3D BB_END(p[prev]) - s;
>   1225=20
>   1226                 if (set =3D=3D 0) {
>   1227                         *first_bad =3D BB_OFFSET(p[prev]);
>   1228                         *bad_sectors =3D BB_LEN(p[prev]);
>   1229                         set =3D 1;
>   1230                 }
>   1231                 goto update_sectors;
>   1232         }
>   1233=20
>   1234         /* Not front overlap, but behind overlap */
>   1235         if ((prev + 1) < bb->count && overlap_behind(bb, &bad, =
prev + 1)) {
>   1236                 len =3D BB_OFFSET(p[prev + 1]) - bad.start;
>   1237                 hint =3D prev + 1;
>   1238                 goto update_sectors;
>   1239         }
>   1240=20
>   1241         /* not cover any badblocks range in the table */
>   1242         len =3D sectors;
>   1243=20
>   1244 update_sectors:
>   1245         s +=3D len;
>   1246         sectors -=3D len;
>                ^^^^^^^^^^^^^^
> Subtraction.
>=20
>   1247=20
>   1248         if (sectors > 0)
>   1249                 goto re_check;
>   1250=20
> --> 1251         WARN_ON(sectors < 0);
>                        ^^^^^^^^^^^
>=20

Yes you are right, this is totally unnecessary and no sense. Let me fix =
it.

Thank you again !

Coly Li


>   1252=20
>   1253         if (unacked_badblocks > 0)
>   1254                 rv =3D -1;
>   1255         else if (acked_badblocks > 0)
>   1256                 rv =3D 1;
>   1257         else
>   1258                 rv =3D 0;
>   1259=20
>   1260         return rv;
>   1261 }
>=20
> regards,
> dan carpenter
>=20

