Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF62ECD1D;
	Mon, 21 Sep 2026 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789957876; cv=none; b=o3YFnOGtLoq97+GBEjl6mC73kzyd0SaNKbg1pNJmXeYxmYVtzUrPUuLPEdOMq1GPzNHiRU8onZIekQGBTc9mPTYpWPbLOb3mIQprBD/PQMECSdQ12lf7Ao7Pxmot07KxgpUV9N2gmvrsfGP0Pr/MYFcl/3bQSTGsG5fWd5oiiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789957876; c=relaxed/simple;
	bh=pu7W+NS/kmy85a4FKBIeUUOBVLfqzAJBfhSIDJ4ekDU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=fs7vaRbaPxGzXmeowiAJXcpKVmN5hordRP+hYdr8ccu7df4M1CvCl+ZdqPL/MTmuIBQ8bBTNH4SEKYckKL/cwx5z5Hh2dLKVJfT30OvtPeRT0qO1cWrnn+eikAoLLVaSga37vH3DZtBpt0u4vZUacT7fY5pZl5VdI7AhkB9IuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M47GL8fs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M47GL8fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836761F000FF;
	Mon, 21 Sep 2026 02:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789957874;
	bh=7iE42CenpV4nRsCuh4QmfYaS/C9hx154C7ZSobuy7cs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M47GL8fsWQmaQWWPN4+o6tg1HvV/AC3CwR41tqAMHDu44TBnDMg4LH7+Crf4oswmP
	 hl6RBpQlAXiUw/irA2E8ITb8GOpbHatWdQuOqpLx4wuLFaCcdpWnWZgGjMye2Uu3Bv
	 4LUuabmFUvQdF3EBgVrgLpBGXPxY54brjd2uMlTPfqs/NJo/iMANnlIBRW/P4K+W5v
	 ntd6WW5FOfKqhBpXXLrnXKOvQsyAPWgdv+eEB8hhuikpuX6IfShqPajDd0SeoLRVFp
	 rZZN+5oAvplPwbcqf34GWkDRG03hn9eui5X2aIw+1FRFxgie+6EibWpWMlUXTWng9Q
	 3RZaRVaGzkoAw==
Content-Type: multipart/mixed; boundary="------------wQvSSSpPeAbBhg2F64kiv8j5"
Message-ID: <0ed54aa9-2cc6-4051-abe7-8144f39f6bed@kernel.org>
Date: Mon, 21 Sep 2026 11:31:11 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20260917 and next-20260918: merge of the block tree breaks
 all zoned devices
To: Tao Cui <cui.tao@linux.dev>, Mark Brown <broonie@kernel.org>
Cc: linux-next@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, cuitao@kylinos.cn
References: <20260920125846.1806521-1-cui.tao@linux.dev>
 <20260920231226.771a0e21@canb.auug.org.au> <aq_5QycDLgQGCc86@sirena.org.uk>
 <d97685b3-f22c-4a27-a7d7-24b2ac7dfbe6@kernel.org>
 <7141040b-5a15-471f-9bbf-9a18bed864e7@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <7141040b-5a15-471f-9bbf-9a18bed864e7@linux.dev>

This is a multi-part message in MIME format.
--------------wQvSSSpPeAbBhg2F64kiv8j5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/21/26 09:49, Tao Cui wrote:
> Hi Mark, Damien,
> 
> 在 2026/9/21 06:37, Damien Le Moal 写道:
>> On 9/21/26 00:18, Mark Brown wrote:
>>> I did say when I did that merge that I had no confidence in it but
>>> nobody responded.  Can you please send me a commit on top of current
>>> -next which fixes up the resolution appropriately?  I can drop extra
>>> fixups in relatively easily, it's probably safer to take something that
>>> you have tested.
>>
>> Mark,
>>
>> My apologies for not replying, but I was traveling. I had looked at your
>> resolution but only quickly and I did not notice the incorrect comparison
>> causing the issue.
>>
>> I am attaching a diff that cleans up the conflict resolution.
>>
> 
> I tested Damien's patch on top of next-20260918.
> 
> It restores the zoned null_blk here: nullb0 is created again, reports
> host-managed, and the queue chunk size is back to 131072 sectors
> (CONFIG_BLK_DEV_NULL_BLK=y, "null_blk.zoned=1 null_blk.gb=1
> null_blk.zone_size=64" on the kernel command line).  So this looks
> good to me.
> 
> Tested-by: Tao Cui <cuitao@kylinos.cn>
> 
> One question for Damien while looking through the merged code: both
> parents had the power-of-two check for zone_sectors, but that check
> also disappears in the merged result.  Was that removal intentional,
> or should it be restored as well?

Mark, Attaching a v2 diff for corrected the conflict resolution. This is on top
of the current linux-next.

Thanks.


-- 
Damien Le Moal
Western Digital Research
--------------wQvSSSpPeAbBhg2F64kiv8j5
Content-Type: text/x-patch; charset=UTF-8; name="v2-blk-zoned.diff"
Content-Disposition: attachment; filename="v2-blk-zoned.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay16b25lZC5jIGIvYmxvY2svYmxrLXpvbmVkLmMKaW5k
ZXggYmFlNDhmMGQzNDY0Li4xOTI2OGFmYjg3NTIgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Jsay16
b25lZC5jCisrKyBiL2Jsb2NrL2Jsay16b25lZC5jCkBAIC0yMDMxLDExICsyMDMxLDE2IEBA
IHZvaWQgZGlza19pbml0X3pvbmVfcmVzb3VyY2VzKHN0cnVjdCBnZW5kaXNrICpkaXNrKQog
c3RhdGljIHVuc2lnbmVkIGludCBkaXNrX2dldF9ucl96b25lcyhzdHJ1Y3QgZ2VuZGlzayAq
ZGlzaywgc2VjdG9yX3QgY2FwYWNpdHkpCiB7CiAJc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGlt
ID0gJmRpc2stPnF1ZXVlLT5saW1pdHM7CisJdW5zaWduZWQgbG9uZyBsb25nIG5yX3pvbmVz
OwogCiAJaWYgKCFjYXBhY2l0eSB8fCAhbGltLT5jaHVua19zZWN0b3JzKQogCQlyZXR1cm4g
MDsKIAotCXJldHVybiBESVZfUk9VTkRfVVBfVUxMKGNhcGFjaXR5LCBsaW0tPmNodW5rX3Nl
Y3RvcnMpOworCW5yX3pvbmVzID0gRElWX1JPVU5EX1VQX1VMTChjYXBhY2l0eSwgbGltLT5j
aHVua19zZWN0b3JzKTsKKwlpZiAobnJfem9uZXMgPiBVSU5UX01BWCkKKwkJcmV0dXJuIDA7
CisKKwlyZXR1cm4gbnJfem9uZXM7CiB9CiAKIC8qCkBAIC0yMTk3LDggKzIyMDIsOCBAQCBz
dGF0aWMgaW50IGRpc2tfaW5pdF9yZXZhbGlkYXRlX2FyZ3Moc3RydWN0IGdlbmRpc2sgKmRp
c2ssCiB7CiAJYXJncy0+ZGlzayA9IGRpc2s7CiAJYXJncy0+bnJfem9uZXMgPSBkaXNrX2dl
dF9ucl96b25lcyhkaXNrLCBhcmdzLT5jYXBhY2l0eSk7Ci0JaWYgKGFyZ3MtPm5yX3pvbmVz
ID4gVUlOVF9NQVgpCi0JCXJldHVybiAtRUlOVkFMOworCWlmICghYXJncy0+bnJfem9uZXMp
CisJCXJldHVybiAtRU5PREVWOwogCiAJLyogQ2FjaGVkIHpvbmUgY29uZGl0aW9uczogMSBi
eXRlIHBlciB6b25lICovCiAJYXJncy0+em9uZXNfc3RhdGUgPSBremFsbG9jKGFyZ3MtPm5y
X3pvbmVzLCBHRlBfTk9JTyk7CkBAIC0yMzIyLDE1ICsyMzI3LDIyIEBAIHN0YXRpYyB2b2lk
IGRpc2tfZHJvcF96b25lX3dwbHVnKHN0cnVjdCBibGtfem9uZV93cGx1ZyAqendwbHVnLCB2
b2lkICpkYXRhKQogc3RhdGljIGludCBkaXNrX3JldmFsaWRhdGVfY2FwYWNpdHkoc3RydWN0
IGdlbmRpc2sgKmRpc2ssCiAJCQkJICAgIHN0cnVjdCBibGtfcmV2YWxpZGF0ZV96b25lX2Fy
Z3MgKmFyZ3MpCiB7CisJc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGltID0gJmRpc2stPnF1ZXVl
LT5saW1pdHM7CisgICAgICAgIHNlY3Rvcl90IHpvbmVfc2VjdG9ycyA9IGxpbS0+Y2h1bmtf
c2VjdG9yczsKIAl1bnNpZ25lZCBpbnQgbnJfem9uZXM7CiAJaW50IHJldCA9IC1FTk9ERVY7
CiAKKwkvKiBDaGVja3MgdGhhdCB0aGUgZGV2aWNlIGRyaXZlciBpbmRpY2F0ZWQgYSB2YWxp
ZCB6b25lIHNpemUuICovCisJaWYgKCF6b25lX3NlY3RvcnMgfHwgIWlzX3Bvd2VyX29mXzIo
em9uZV9zZWN0b3JzKSkgeworCQlwcl93YXJuKCIlczogSW52YWxpZCBub24gcG93ZXIgb2Yg
dHdvIHpvbmUgc2l6ZSAoJWxsdSlcbiIsCisJCQlkaXNrLT5kaXNrX25hbWUsIHpvbmVfc2Vj
dG9ycyk7CisJCWdvdG8gZHJvcF9hbGxfendwbHVnczsKKwl9CisKIAlhcmdzLT5jYXBhY2l0
eSA9IGdldF9jYXBhY2l0eShkaXNrKTsKIAlucl96b25lcyA9IGRpc2tfZ2V0X25yX3pvbmVz
KGRpc2ssIGFyZ3MtPmNhcGFjaXR5KTsKIAlpZiAoIWFyZ3MtPmNhcGFjaXR5IHx8ICFucl96
b25lcykKIAkJZ290byBkcm9wX2FsbF96d3BsdWdzOwotCWlmIChhcmdzLT5jYXBhY2l0eSA+
PSBhcmdzLT5ucl96b25lcykKLQkJZ290byBkcm9wX2FsbF96d3BsdWdzOwogCiAJLyoKIAkg
KiBDaGVjayBpZiB0aGUgY2FwYWNpdHkgaGFzIGNoYW5nZWQuIElmIGl0IGRpZCwgYXNzdW1l
IHRoYXQgdGhlIGRldmljZQo=

--------------wQvSSSpPeAbBhg2F64kiv8j5--
