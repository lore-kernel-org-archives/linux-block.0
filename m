Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A68296BBC;
	Sun, 20 Sep 2026 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789943883; cv=none; b=WctDOAqpduvnUq9M8VpYBVZ35xWkRbd2wZlR/plXJrulttLf60oeroZgaO5+eelfWDevv2zJMzLFq6lABn57XbO2/jDLywGakkGLdePw8AjdJkpcDolusuwSmZzNvlIRtPLCihPtbn8cDEGP7KA/3YLpu1B104Q9lKwWsuzvJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789943883; c=relaxed/simple;
	bh=9+s+2pxLbn8lyl5+/7k2oEa8NJRkdDisP8AR/5LnhDo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=l4VEqSxGJ/0sydA0HT9aky0NPGgdqyJdEQDRvTfEb60kUquTNojEi+VFin9u501Z3l0utlVhjTXMWzgGWnaxBhzAQD2YDUNseBXMOpKYDbsv1ZwAMNrEPC2II/iSTHTt2w356jYfGVcWGh4WaE7Vd4S2VQ8mWc6h5rZcPFHeWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlpSBtCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlpSBtCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C341F000FF;
	Sun, 20 Sep 2026 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789943881;
	bh=apatrL5ufL7iUOjqdOHsjhe+0MEJgZ6kYLJ7beXub9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RlpSBtCWzSqN7kePsDrRYbAk7Dvg9f+KWqg5aQ9wHsYV+eDP353DWBIMRVOEx60V+
	 vO85b3xPuccmUzJOYniT4VVbQfOxp1/6HAqPTMgPmvVoacsyzGjic64thZUOgVtHot
	 7jQGguB8wPa5MnOEU/8KFv7eqen1qf7QLFSO7S4fAdRldsrgbmnmPxohhww5SuqAQC
	 JxWfwM7Okm9nrhO5O/y7ttefnwQ8DogKSxDeiwK6Kuhbn+ydIeWZju2dK8jiJXu3zz
	 ZCT3Idazzx1zMnkCQuXUrItieKAwp/Cc2gGhYVBQJQxVcO7cLuva3iEHCZITrFQSP+
	 wF4n6qEMUMI6Q==
Content-Type: multipart/mixed; boundary="------------ylaHPIcG2se00g0cjkSyW2x4"
Message-ID: <d97685b3-f22c-4a27-a7d7-24b2ac7dfbe6@kernel.org>
Date: Mon, 21 Sep 2026 07:37:58 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20260917 and next-20260918: merge of the block tree breaks
 all zoned devices
To: Mark Brown <broonie@kernel.org>
Cc: Tao Cui <cui.tao@linux.dev>, linux-next@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, cuitao@kylinos.cn
References: <20260920125846.1806521-1-cui.tao@linux.dev>
 <20260920231226.771a0e21@canb.auug.org.au> <aq_5QycDLgQGCc86@sirena.org.uk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aq_5QycDLgQGCc86@sirena.org.uk>

This is a multi-part message in MIME format.
--------------ylaHPIcG2se00g0cjkSyW2x4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/26 00:18, Mark Brown wrote:
> I did say when I did that merge that I had no confidence in it but
> nobody responded.  Can you please send me a commit on top of current
> -next which fixes up the resolution appropriately?  I can drop extra
> fixups in relatively easily, it's probably safer to take something that
> you have tested.

Mark,

My apologies for not replying, but I was traveling. I had looked at your
resolution but only quickly and I did not notice the incorrect comparison
causing the issue.

I am attaching a diff that cleans up the conflict resolution.

Thanks!

-- 
Damien Le Moal
Western Digital Research
--------------ylaHPIcG2se00g0cjkSyW2x4
Content-Type: text/x-patch; charset=UTF-8; name="blk-zoned.diff"
Content-Disposition: attachment; filename="blk-zoned.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay16b25lZC5jIGIvYmxvY2svYmxrLXpvbmVkLmMKaW5k
ZXggYmFlNDhmMGQzNDY0Li5kZDhhNzJlMzUyYzEgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Jsay16
b25lZC5jCisrKyBiL2Jsb2NrL2Jsay16b25lZC5jCkBAIC0yMDMxLDExICsyMDMxLDE2IEBA
IHZvaWQgZGlza19pbml0X3pvbmVfcmVzb3VyY2VzKHN0cnVjdCBnZW5kaXNrICpkaXNrKQog
c3RhdGljIHVuc2lnbmVkIGludCBkaXNrX2dldF9ucl96b25lcyhzdHJ1Y3QgZ2VuZGlzayAq
ZGlzaywgc2VjdG9yX3QgY2FwYWNpdHkpCiB7CiAJc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGlt
ID0gJmRpc2stPnF1ZXVlLT5saW1pdHM7CisJdW5zaWduZWQgbG9uZyBsb25nIG5yX3pvbmVz
OwogCiAJaWYgKCFjYXBhY2l0eSB8fCAhbGltLT5jaHVua19zZWN0b3JzKQogCQlyZXR1cm4g
MDsKIAotCXJldHVybiBESVZfUk9VTkRfVVBfVUxMKGNhcGFjaXR5LCBsaW0tPmNodW5rX3Nl
Y3RvcnMpOworCW5yX3pvbmVzID0gRElWX1JPVU5EX1VQX1VMTChjYXBhY2l0eSwgbGltLT5j
aHVua19zZWN0b3JzKTsKKwlpZiAobnJfem9uZXMgPiBVSU5UX01BWCkKKwkJcmV0dXJuIDA7
CisKKwlyZXR1cm4gbnJfem9uZXM7CiB9CiAKIC8qCkBAIC0yMTk3LDcgKzIyMDIsNyBAQCBz
dGF0aWMgaW50IGRpc2tfaW5pdF9yZXZhbGlkYXRlX2FyZ3Moc3RydWN0IGdlbmRpc2sgKmRp
c2ssCiB7CiAJYXJncy0+ZGlzayA9IGRpc2s7CiAJYXJncy0+bnJfem9uZXMgPSBkaXNrX2dl
dF9ucl96b25lcyhkaXNrLCBhcmdzLT5jYXBhY2l0eSk7Ci0JaWYgKGFyZ3MtPm5yX3pvbmVz
ID4gVUlOVF9NQVgpCisJaWYgKCFhcmdzLT5ucl96b25lcykKIAkJcmV0dXJuIC1FSU5WQUw7
CiAKIAkvKiBDYWNoZWQgem9uZSBjb25kaXRpb25zOiAxIGJ5dGUgcGVyIHpvbmUgKi8KQEAg
LTIzMjksOCArMjMzNCw2IEBAIHN0YXRpYyBpbnQgZGlza19yZXZhbGlkYXRlX2NhcGFjaXR5
KHN0cnVjdCBnZW5kaXNrICpkaXNrLAogCW5yX3pvbmVzID0gZGlza19nZXRfbnJfem9uZXMo
ZGlzaywgYXJncy0+Y2FwYWNpdHkpOwogCWlmICghYXJncy0+Y2FwYWNpdHkgfHwgIW5yX3pv
bmVzKQogCQlnb3RvIGRyb3BfYWxsX3p3cGx1Z3M7Ci0JaWYgKGFyZ3MtPmNhcGFjaXR5ID49
IGFyZ3MtPm5yX3pvbmVzKQotCQlnb3RvIGRyb3BfYWxsX3p3cGx1Z3M7CiAKIAkvKgogCSAq
IENoZWNrIGlmIHRoZSBjYXBhY2l0eSBoYXMgY2hhbmdlZC4gSWYgaXQgZGlkLCBhc3N1bWUg
dGhhdCB0aGUgZGV2aWNlCg==

--------------ylaHPIcG2se00g0cjkSyW2x4--
