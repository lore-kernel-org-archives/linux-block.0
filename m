Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47DD32AABD
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789911872; cv=pass; b=F+2G0IrOipOqF7TY9V0qligsQEzcXt75BERmkdjpz0afNa/bX79WkSwn99uY4L3XDXhz8MukEyymYNmSQEvnJ4HBLy3vJil2OsVAB75uIgkx0Y64Q6o/+F1DFKbdknlJ/VJnMekz1sHhdEcl/5EkR/aA5ewwVl66Iwwa+D8gSJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789911872; c=relaxed/simple;
	bh=UXA2zp3XI42BtFvhO8xS/jRT2Pk6aJkddDnJK1FECbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb7+lNvOFbLBVZBuR52lx+HaLNH1fmyqmy5kiFrLC5guZNCjleOPI3RGKsfzzOQj5T5kWQx6B4Ain+gIKv4xGEZpLYy+8P1sZjZYZgBjOt4ew5hxy7qcgB+750EmesUJr/m0C8jiMEWYm67fdDBaXhCNgSqod8p+AmnkOyhaTVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgyK3aQ/; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgyK3aQ/"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a9b9so1488804fac.2
        for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 06:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789911866; cv=none;
        d=google.com; s=arc-20260327;
        b=q34IVnQzu/s1nkMNThZwqb6N89pWD3J1sTRDAldukaJmkkcWuQMEFuI1JUVKDxFWOZ
         fpGv/Fapp9c4QGpRmoOeczebIolbFlHpBHjwEtZ5ONFfuzcPZ9qAxDelRIYUlQNe+O0L
         5u+S9RXCnEi6Fk2DcXtxJAFjhZaBpCbQxkxxdpKZbf2fHny6k/dqEK825adBD0C+TI+w
         wMErABHfgUjlyy0qOHdYkSJ52RzYrbhuiSWYuh878i6k+2S5EOqiykkMlogcndfmAHat
         QCUGJriePMzXigtE37kppvZ1EFLsi6cBM8+SjqSuA79N8eo1LhC+KJzHxYhq57FrNQCM
         L+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jEX4twDo/lUtcmDOQIlSIon0G7yYx0diVyTZgm1EyJs=;
        fh=vcob7zHRqR3w4I9W6YDW1PsI7fVYs7plb+DSrYtqoyw=;
        b=XM69QS2IeXPcSYACRgoFnClO6ZLAw0l3J/bsK5VdtU3UUiWRvjEFS+2fNlBwbDg0m5
         KfnO3mny/G3iksbQketF111iQcloqXdD2GcCg1wlIcQmI2W9Uz2hrLOUGAO9YqzJShfg
         FYj5RQqDvE7mENqwzvCuviqy5nE4NXJ/6hGU3HzsP9kILys6A8wQG9HHG4gJjXDAsMj5
         EX1mCXld0f4D7AEYsXSS0EqpsUJKzbHufvp+tz7h4OooWmsY2/Mwubu0sjHnU5+93vT9
         FYXvhCF4Q58wxoJ7n/2rxSJgyjE9QGtzt8jqKtCeT4kVIbjLQdD60fXdKqGfXwlfjNWY
         e94Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789911866; x=1790516666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jEX4twDo/lUtcmDOQIlSIon0G7yYx0diVyTZgm1EyJs=;
        b=MgyK3aQ/6h1HplUODTa1qy7WG0z8Z5ZdGNO0jOHmwacei06LtsH2Fk6oVa0IXXSrsn
         ndu0aaG56AS0YeFvEAR8ZUs0yRuMUMpuZiZHCPgvuFot1DgKOlMeGmsQvuX7GBRBP18b
         QXZW4oPS9vTsaOGkU3PeJwzgvOyvMI8zFDQJgxqNqD+ZZucweBFQeE4eAvWK820xXX0+
         itGJyuKMIztS8wjbPwZPt+slgpFESRDFhJvCzvEsou45HxdwMKYpewzLqVVcYxGESHpL
         jcyZ4AQ+aF2tX+mBg+ztnprVe3Rh1YEonH7Kb7/ZZ7oikbiu0kMLO52ZH7f9aQbInsbA
         2rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789911866; x=1790516666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEX4twDo/lUtcmDOQIlSIon0G7yYx0diVyTZgm1EyJs=;
        b=d6WxSPPydwF8/qNzCzFkzbukVaFBgbn77QxNpSWJbmeHGC4R7c8jruaJ5O8rJT8LGr
         BkHEZ6iBJUs5YyOHYAZ3QDctHuGJwCZ9bWeASN6ne4pjMjkgQWUOXsTV//zfwqVU5BT0
         w7/wTUa4Xe/zcSOUf4oUWOwJ1WslG2cNpElC6nG7J0yBMQBjTmtbVLUrH2HFD4t/uePa
         VERg0LLUBoOfrR0dsO/BVnfR4ER7Bo3T4O11jwmgithOUTWfXodyBUOii+nI0rmEHFx3
         5QaVq1jvJMc89xBg8xAgOsAegzdbbPoisOmYizV6Cs57xDTIJdqV3bDN8guIc1PNNKTN
         VHxg==
X-Forwarded-Encrypted: i=1; AKwUvBzGWtqHYsyUabB+WccpL7fHZ1DprnR/S4qdRFtC2tJen+nN4wG/Puer/sZlACZecPOw4boCWEmVpNylhg==@vger.kernel.org
X-Gm-Message-State: AFuF++n5nmhtVPcugEFrCdCyhGTnFhnoh4Aej6Qjsr9rG8o0GKiiWKZ2
	sTeCm/x6Wo/lC9scbI0kkYQchzz/vRQb7Vt2XS9nvn6/5ZGQFdgU7qVo0OCZDqmDXj7PU4FaatO
	oyI63HL+zK5+ZXuvsNydAHjjwzxCa6vU=
X-Gm-Gg: AYBFou2S58D+OtX8AW9Cu3J9x7ymHnG1/jz8qaFZs/dFnvFdFjIbFSOCG1RX8bl0A2Y
	cFk/y9w5Zlf011GvoVBWpA3DBO6/cZRs7MDjJLpWalT+Q7H4ahpsMCldGZJJrSZW3E2UbQYll9V
	TWTnjj/jh0UzoSkOiZ4rAweGAolPJHaFg8HQSk2S2sX2BRTPIsPKkU8y+hSNKsc55rsxnZF/FJV
	UFJV3SKixko4bBMfe0HAKlZ1tR3beWDeJ/dBgiv4CwEHz5o/ez62X3ytTvxmLpkVgtMYeSYB+Ti
	bYio0PvqXJk4ZHzjN6mhn/QMyaEBm3Pl1kdRJAloLdHalqH8DpLCA3xiKRoVJSixMs2gLRf9Evk
	THQlhkiwWr6ouT2Fea7DoBi6yJRqXjyk+QNKsNi75G5JktlzNEhcw1723
X-Received: by 2002:a05:6870:b28e:b0:47b:7709:5568 with SMTP id
 586e51a60fabf-486e564dd74mr6640425fac.10.1789911866617; Sun, 20 Sep 2026
 06:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914110145.41627-2-dirk@gouders.net>
In-Reply-To: <20260914110145.41627-2-dirk@gouders.net>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 20 Sep 2026 08:44:15 -0500
X-Gm-Features: AcwNN1VT3jlE_HOBtpGzW4wVVv5zCIPL3np61n-V3xFqz7HoPcojwrQzLe6U4Bw
Message-ID: <CACVXFVNZga4LMOep2U9XgGHE1X0+FMESKL9uYmeAKETf2qu1yQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: ublk: fix unused_result error
To: Dirk Gouders <dirk@gouders.net>
Cc: Shuah Khan <shuah@kernel.org>, Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Linux Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 6:11=E2=80=AFAM Dirk Gouders <dirk@gouders.net> wro=
te:
>
> Commit 166b476b8dee (selftests/ublk: add shared memory zero-copy
> support in kublk, 2026-03-31) introduced a write(2), ignoring its
> return value and thus causing an error, when building.
>
> Fix this by using the common workaround "(void)!" to trick the
> compiler the result is being used.
>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  tools/testing/selftests/ublk/kublk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftes=
ts/ublk/kublk.c
> index 2400b4615766..5b19bfcfa8d7 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1589,7 +1589,7 @@ static int ublk_start_daemon(const struct dev_ctx *=
ctx, struct ublk_dev *dev)
>
>         /* Signal listener thread to stop and wait for it */
>         if (linfo.stop_efd >=3D 0) {
> -               write(linfo.stop_efd, &stop_val, sizeof(stop_val));
> +               (void)!write(linfo.stop_efd, &stop_val, sizeof(stop_val))=
;
>                 pthread_join(listener, NULL);
>                 close(linfo.stop_efd);
>                 ublk_shmem_sock_destroy(dinfo->dev_id, linfo.sock_fd);

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
