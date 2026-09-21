Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42045D918
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981968; cv=none; b=NX4wTUuw2Y21CALIm7k8HQ0Nmy/JDaWzKA9uGiyY/vsqy0Qb/OvmnRQFHB9mfelS/xs+22ehuCKJzwYUEhvQJHFPY2kEOoyL3vZ1N3nYEBoYkkkcn0X8Z+w4CwPAVLK4caLzSGB9MiVZYTqNIHj9sqTayfmMfn9bLfpLBjFUtMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981968; c=relaxed/simple;
	bh=3Xw1p8G0AHRqUmNK3rQ94pM9U+fqhG0AXQrTKQWNS94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRnK50tSUEI0bMUPvFQMw+lLu8HKBWkZtMu0njwsWgzylKfbqz3Cp8YGJMkORHpH3u+g5WPbpTDV9EIMGfTlMuhXLzHN5r/6piP3bROPFpW/A304Gg5wLlK+2bf4Ez7b3HiFniwF3pIAkOD03pNGSW4YOCqRrM20wSrHQ4ZUGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76ec395so23980701cf.2
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 02:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789981965; x=1790586765;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PgveYix98Rp2X24AFbGYCW9BQGFKiOVojzHndnJC0kc=;
        b=Qy7HfmziCovgrnMBs3f/jzH1FrxxdqpWqiQPmAHDOCYvL3VclPmC5hGUs9QEpHx7Af
         svFAVdGQND1YCDe6Jan3qz5Q+qCHw78cidZLB/FYj08iTO8zT2SmDMqw21/qDXGr5KNQ
         9tmwl9cBcsCFMBM6LAcTixN+wsEzm+HtmIriVFH9KTGt2oqjJnWWK/bvKPEwqnYGd1YK
         ztJpQEHL8Axd0TBhjI7UOUF9IV0mvABYGCoYWung5h2lXGBmPj0CeEwgxVRfB9A72Z0O
         M5raGUjJVSPhyOnPtjRBPgy//wtoH6u6tcPd3nIQjbJrlzIS2ZIjrmOV5r3I3Ia7N5Fz
         0YKw==
X-Gm-Message-State: AFuF++lX3wN28Fj2ECNFB5lgUNomg8lrEy6tAqyHQo5q4CXpWEpkza/6
	NQX2ZhljdXhgvO1Dy43arScl1MAsRWgC5M+ceAAA3/OUW/wIF5DjlllYZYnvIgJj7KQ=
X-Gm-Gg: AYBFou1ccQZv0mbFck2OCwiJJHn1zht0vjMfm0xwM68oVkUcA8eAE+TtFb5vUOrGimw
	kxaAXNtrHke9ekq9alBHHJwXUxoLWn6KOzOHkGekhuXqur64irDY/hu66BFrOAvzXmw6wT71Xwd
	55cyDRCOOw79r2n0Tc+fkETjgoHeyIXqhtZYUi0YCLMRlwiPcZNLcFBLBjx2aB7K+mEgYrbHd4E
	XSfYM1yAy7DTkETa12cFru9UCsQmT47eaMj1tnv/cr4MVlaDvazjDHVgLgBmtgd4gEed0kW6DKN
	nKH5DobGVTsTeaRDcrohY4JzhXdMCXx0/nxG8wQik2bRJv5jNWfYtvUq3umPGFGiwNGIMbicTtB
	w/gFhlDg3dZteVgyN34D2XrEksk1hZTxto/ht7Sz7FZzwHTLKJ4DQSeRvVVN2DY+/M83JcMgraw
	Hi+VYKfrAhmg6RCkWyfAf+QQPC0etYbp5hrQZR5z/xQEWcSYoY1BwJa5N3/5XCAhXQ2+C8C83d6
	MNn1Z8zVq/gOBzwH5GKTApc2pPQ
X-Received: by 2002:ac8:5a89:0:b0:530:f8f6:4ded with SMTP id d75a77b69052e-532b7362febmr92506811cf.56.1789981965377;
        Mon, 21 Sep 2026 02:12:45 -0700 (PDT)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com. [74.125.230.205])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae5e91dfsm59195291cf.7.2026.09.21.02.12.45
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:12:45 -0700 (PDT)
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d0d5ae11so29753061cf.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 02:12:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2311:10b0:93b:fb3c:2d09 with SMTP id
 af79cd13be357-93bfb3c2d27mr518547385a.66.1789981964786; Mon, 21 Sep 2026
 02:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKTh27_iPvKWV8_bLMwwhEZAD+XPXimBdpz4D8iuue8mSh2A=g@mail.gmail.com>
In-Reply-To: <CAKTh27_iPvKWV8_bLMwwhEZAD+XPXimBdpz4D8iuue8mSh2A=g@mail.gmail.com>
From: 0wnerD1ed <l7z@0b1t.tech>
Date: Mon, 21 Sep 2026 17:12:31 +0800
X-Gmail-Original-Message-ID: <CAKTh279TUXfzjd52aY7op+TL5VihhXJvy=JSp5mjXz=r272FcQ@mail.gmail.com>
X-Gm-Features: AcwNN1XS36jXZjKcvaM-VP5y4pPZnoWFCKHbsi2tsaezrDgCcV3qkf960Kvee8o
Message-ID: <CAKTh279TUXfzjd52aY7op+TL5VihhXJvy=JSp5mjXz=r272FcQ@mail.gmail.com>
Subject: Re: [PATCH blktests] block/046: skip with the new XFS read-bounce implementation
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: multipart/mixed; boundary="0000000000002a8589065bfaa79f"

--0000000000002a8589065bfaa79f
Content-Type: text/plain; charset="UTF-8"

The v1 message was corrupted by Gmail web, tabs were converted to spaces
and added lines were hard-wrapped. The code is unchanged. Please use the
attached v2 format-patch, which preserves the original whitespace.

--0000000000002a8589065bfaa79f
Content-Type: application/octet-stream; 
	name="0001-block-046-skip-with-the-new-XFS-read-bounce-imple.v2.patch"
Content-Disposition: attachment; 
	filename="0001-block-046-skip-with-the-new-XFS-read-bounce-imple.v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mub0zyp00>
X-Attachment-Id: f_mub0zyp00

RnJvbSA1ZGM1NDU2NmVlNmY0NTA3YzA3OWM5YzIwN2NiN2ZmOWJmMDZlOTJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAwd25lckQxZWQgPGw3ekAwYjF0LnRlY2g+CkRhdGU6IE1vbiwg
MjEgU2VwIDIwMjYgMTY6NTA6MTIgKzA4MDAKU3ViamVjdDogW1BBVENIIGJsa3Rlc3RzIHYyXSBi
bG9jay8wNDY6IHNraXAgd2l0aCB0aGUgbmV3IFhGUyByZWFkLWJvdW5jZQogaW1wbGVtZW50YXRp
b24KVG86IFNoaW4naWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+
CkNjOiBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmcsCiAgICBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT4KCmJsb2NrLzA0NiB1c2VzIGEgZGVsaWJlcmF0ZWx5IG1pc2FsaWduZWQgb25l
LWJ5dGUgaW92ZWMgdG8gZXhlcmNpc2UgdGhlCnNwZWNpYWwgYnZlYyBsYXlvdXQgaW4gYmlvX2lv
dl9pdGVyX2JvdW5jZV9yZWFkKCkuCgpUaGUgbmV3IFhGUyBsYXp5IHJlYWQtYm91bmNlIGltcGxl
bWVudGF0aW9uIG5vIGxvbmdlciBzZXRzCklPTUFQX0RJT19CT1VOQ0UgYmVmb3JlIGV4dHJhY3Rp
bmcgdGhlIHVzZXIgcGFnZXMuICBUaGUgb3JkaW5hcnkgcGF0aCBub3cKcmVqZWN0cyB0aGF0IGlv
dmVjIHdpdGggRUlOVkFMLCBhbmQgYSBsYXRlciBwYXRjaCByZW1vdmVzIHRoZSBsZWdhY3kgaGVs
cGVyCmVudGlyZWx5LgoKRGV0ZWN0IHRoZSBwZXItbW91bnQgY3N1bS9yZWFkX2JvdW5jZSBpbnRl
cmZhY2UgYW5kIG1hcmsgdGhlIHRlc3Qgbm90IHJ1bgphZnRlciBjbGVhbmluZyB1cCB0aGUgWEZT
IG1vdW50IGFuZCBudWxsX2JsayBkZXZpY2UuICBUaGlzIHJldGFpbnMgdGhlCnJlZ3Jlc3Npb24g
Y292ZXJhZ2Ugb24gb2xkZXIga2VybmVscyB3aXRob3V0IHRyZWF0aW5nIHRoZSBleHBlY3RlZCBF
SU5WQUwKYXMgYSBzdWNjZXNzZnVsIHJlc3VsdC4KClJlcG9ydGVkLWJ5OiBTaGluJ2ljaGlybyBL
YXdhc2FraSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPgpMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yL2FyRE4xVWRaSXlkTkxVanpAc2hpbm1vYgpMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjYwOTIxMDgyMjQwLkdBMTk4MzNAbHN0LmRlClNpZ25lZC1vZmYtYnk6
IDB3bmVyRDFlZCA8bDd6QDBiMXQudGVjaD4KLS0tCkNoYW5nZXMgc2luY2UgdjE6Ci0gcmVzZW5k
IHdpdGggdGhlIG9yaWdpbmFsIHdoaXRlc3BhY2U7IEdtYWlsIGNvbnZlcnRlZCB0YWJzIHRvIHNw
YWNlcyBhbmQKICBoYXJkLXdyYXBwZWQgYWRkZWQgbGluZXMgaW4gdGhlIHYxIG1lc3NhZ2UKCiB0
ZXN0cy9ibG9jay8wNDYgfCAxOSArKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwg
MTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2Jsb2NrLzA0NiBiL3Rlc3RzL2Js
b2NrLzA0NgppbmRleCA1Zjg3NGJjLi5lOTdmNTgzIDEwMDc1NQotLS0gYS90ZXN0cy9ibG9jay8w
NDYKKysrIGIvdGVzdHMvYmxvY2svMDQ2CkBAIC0yMyw2ICsyMyw3IEBAIHJlcXVpcmVzKCkgewog
dGVzdCgpIHsKIAlsb2NhbCBibG9ja19zaXplCiAJbG9jYWwgbW91bnRfZGlyPSIke1RNUERJUn0v
bW50IgorCWxvY2FsIHJlYWRfYm91bmNlPSIvc3lzL2ZzL3hmcy9udWxsYjEvY3N1bS9yZWFkX2Jv
dW5jZSIKIAlsb2NhbCB0ZXN0X2ZpbGU9IiR7bW91bnRfZGlyfS90YXJnZXQiCiAKIAllY2hvICJS
dW5uaW5nICR7VEVTVF9OQU1FfSIKQEAgLTQyLDYgKzQzLDI0IEBAIHRlc3QoKSB7CiAJCV9leGl0
X251bGxfYmxrCiAJCXJldHVybgogCWZpCisKKwkjIFRoZSBsYXp5IFhGUyByZWFkLWJvdW5jZSBp
bXBsZW1lbnRhdGlvbiByZXBsYWNlZCB0aGUgbGVnYWN5IGJsb2NrLWxheWVyCisJIyBwYXRoIHdo
b3NlIHNwZWNpYWwgYnZlYyBsYXlvdXQgdGhpcyB0ZXN0IGV4ZXJjaXNlcy4KKwlpZiBbWyAtZSAi
JHtyZWFkX2JvdW5jZX0iIF1dOyB0aGVuCisJCWlmICEgdW1vdW50ICIke21vdW50X2Rpcn0iID4+
IiR7RlVMTH0iIDI+JjE7IHRoZW4KKwkJCWVjaG8gImZhaWxlZCB0byB1bm1vdW50IFhGUyIKKwkJ
CV9leGl0X251bGxfYmxrCisJCQlyZXR1cm4gMQorCQlmaQorCQlybSAtcmYgIiR7bW91bnRfZGly
fSIKKwkJaWYgISBfZXhpdF9udWxsX2JsazsgdGhlbgorCQkJZWNobyAiZmFpbGVkIHRvIHJlbW92
ZSBudWxsX2JsayIKKwkJCXJldHVybiAxCisJCWZpCisJCVNLSVBfUkVBU09OUys9KCJsZWdhY3kg
cmVhZC1ib3VuY2UgaW1wbGVtZW50YXRpb24gaXMgbm90IHByZXNlbnQiKQorCQlyZXR1cm4KKwlm
aQorCiAJZGQgaWY9L2Rldi96ZXJvIG9mPSIke3Rlc3RfZmlsZX0iIGJzPTFNIGNvdW50PTEgY29u
dj1mc3luYyBcCiAJCXN0YXR1cz1ub25lCiAJYmxvY2tfc2l6ZT0kKGJsb2NrZGV2IC0tZ2V0c3Mg
L2Rldi9udWxsYjEpCi0tIAoyLjU0LjAK
--0000000000002a8589065bfaa79f--
