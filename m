Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A23195E8
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562069; cv=none; b=RZD2kwk4WiXXAcRRwfQRxRRVrlr7wDYlvTpczhHf8Xd4UtqZcqWv1ADT6tP9jx6zg0py2VWnPXTRd1EBCNT6kDnhTa3DVa+6eKPyddxzqwVHCDEQtvSeUBy50XibvMjYKUexUpHKOkwr+Sn6dtLeEyUk/kXB9jkRVbdqdFqa5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562069; c=relaxed/simple;
	bh=1VmR8Kkpaw5Jnmcy3b+kUQsvs1wTo9T/0AMBqtyOAcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjKJu/lZaru889y9aMk2+q+r9/ZuU/N+SRkYL4azMhBkIruAgE1+YUA+FN9roNREoOhMqzHCXOh7fg3oY1pEs9evDB0eFc8FsHdPfGQE6dEYW++vo7DAaEFK3JuNUW49/KkRnz3t/5HWj9grAID6p7i1yqmsjsyQ5IVEo6ohZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nxn5rYId; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPvIBo6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nxn5rYId";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPvIBo6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768562066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/swVgDB3UZWLJtgAMRxwsG0G/0q1Yp9koeHNSg/Ack=;
	b=Nxn5rYId4UjHuE2kFb5lAo3G7N6Ctt5aFU/r/EL2deRj4WSXs8TnlAG2p/XSskMlvzkygW
	4+O0ZoXd9NfsZaNqjD4ZUNubhxK4AHxj5/jW2Oc1V0lGBtUnwWDlK4MsSODUkEZ1JqeMhT
	qgi7IpqOQ95NzyrX8LfRnLgA4TyHQ9s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-l2X_NxDVObGKfDosYhPchw-1; Fri, 16 Jan 2026 06:14:25 -0500
X-MC-Unique: l2X_NxDVObGKfDosYhPchw-1
X-Mimecast-MFC-AGG-ID: l2X_NxDVObGKfDosYhPchw_1768562064
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59b78adfc09so1670750e87.0
        for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 03:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768562064; x=1769166864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/swVgDB3UZWLJtgAMRxwsG0G/0q1Yp9koeHNSg/Ack=;
        b=PPvIBo6X5A4ptsosXc2msDu6TITF3JEQx0DlJvYgxeW6gbVr7nfLjCTi/0sNWvXVT1
         DshGYvxzkz/CyuYUQCkLeUOrbZNfHufKIl+nej5fkORQg2HPsWn/1ueF2TGLTUKFYohr
         dI18W7aNUBdQQbgSvUIeC7xbH3nOhK3N9eF9HFAVUSI8uvHkv4sGzE9yr54MoI0fnnaL
         7jIhRDh2wesLD9fEwVBnulTg1YtHWb+4A1H0L8OAsCwrn4OXsqY2Z+Jcem+Ymza0gH1t
         xMSs7JK4jn8grWT2AAlK8v4YolkBLn45pUhbI2PchZhyLWlhh5Y9zaCPgVGdKqzjcAVz
         BcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768562064; x=1769166864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/swVgDB3UZWLJtgAMRxwsG0G/0q1Yp9koeHNSg/Ack=;
        b=DBXoGjrp3skavUCNdAcaD+xoSktBMCSH328mVB7CZPQtpAi4PjY/lok1A2PqZg675b
         gorSHFLEVb65Ca0Ksk2fnyNBk3+z6bOqv4mtRlgJ7nCCWq0vnKDEkkyvYJ/WMbYjQSBv
         LG7JXq+aXD9ChIdO62mSXFQmSiXoETlyjsAfBevQpF/4ChLGr4aqc9tmukDkX93AQamP
         Z/OEfqb13SmUgWlqDOdSR918ysTlXbQ+0ESjOa1OblLskGdiI0uDOboYlGMwqhEKVfYQ
         7gYDACL9YBDhD+tJb3S8cI30bEPUoR/xkrJM1MPG9t2fsUibOCr+tgv8CPagyUKVL4K2
         1wqg==
X-Gm-Message-State: AOJu0YytGRhKyQ/99F/G7aOZYPi5GtOMT96C7VowXgyR7gJmjXMwO2M9
	Upk7JjLzQSXaHy5qkRttAhRVnQ136rye9TP0rp4dtqBcPI76v1S72AJzS8qE/JwtX1Cls1MJmyr
	RA69vqYmDv+10TjpwFQvmgbUUy7eqtrbA8m2COFPlviXav+9SAHNjK3EBjrTPB9fZLldU2L7Iuf
	BZud/C/wg7LsROHm/GBbf3GZh+J1PSOJ0YcJghxuk=
X-Gm-Gg: AY/fxX6+dQfzO7Or0wnmApAP4dLPDRTm2+de4VSCDo3vd7V3noEJHWXCNy+7Ur6MU22
	tuwP5zWrPFQFIlzK0/IRbUgguClbQLYaONDH6uWiHnvrrLvQi8w2C5BfZ8yYCMifUp5pPI4yQj5
	hlnlMLoXOe9KURPgGxNl/gSP6ZHNZKmO98PRI4Cz4cXo2P12pYpJAkD5oO/IOjH3ncJ2E=
X-Received: by 2002:a05:6512:3f20:b0:59b:2670:aa5 with SMTP id 2adb3069b0e04-59baffd29famr637731e87.37.1768562063756;
        Fri, 16 Jan 2026 03:14:23 -0800 (PST)
X-Received: by 2002:a05:6512:3f20:b0:59b:2670:aa5 with SMTP id
 2adb3069b0e04-59baffd29famr637722e87.37.1768562063314; Fri, 16 Jan 2026
 03:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113095134.1818646-1-nilay@linux.ibm.com>
In-Reply-To: <20260113095134.1818646-1-nilay@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 16 Jan 2026 19:14:11 +0800
X-Gm-Features: AZwV_QhkcJmbytiAKG0vxewEFZePe5Hk4bZotZyThrul9hScAhO7VqpNyvaDrGY
Message-ID: <CAHj4cs9dDcQdExzwyENa5wcfPHChy4Q8Xv-vtpNuAPX7Ue9AAQ@mail.gmail.com>
Subject: Re: [PATCH blktests] check: add kmemleak support to blktests
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:52=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> Running blktests can also help uncover kernel memory leaks when the
> kernel is built with CONFIG_DEBUG_KMEMLEAK. However, until now the
> blktests framework had no way to automatically detect or report such
> leaks. Users typically had to manually setup kmemleak and trigger
> scans after running tests[1][2].
>
> This change integrates kmemleak support directly into the blktests
> framework. Before running each test, the framework checks for the
> presence of /sys/kernel/debug/kmemleak to determine whether kmemleak
> is enabled for the running kernel. If available, before running a test,
> any existing kmemleak reports are cleared to avoid false positives
> from previous tests. After the test completes, the framework explicitly
> triggers a kmemleak scan. If memory leaks are detected, they are written
> to a per-test file at, "results/.../.../<test>.kmemleak" and the
> corresponding test is marked as FAIL. Users can then inspect the
> <test>.kmemleak file to analyze the reported leaks.
>
> With this enhancement, blktests can automatically detect kernel memory
> leaks (if kerel is configured with CONFIG_DEBUG_KMEMLEAK support)  on
> a per-test basis, removing the need for manual kmemleak setup and scans.
> This should make it easier and faster to identify memory leaks
> introduced by individual tests.
>
> [1] https://lore.kernel.org/all/CAHj4cs8oJFvz=3DdaCvjHM5dYCNQH4UXwSySPPU4=
v-WHce_kZXZA@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQO=
kRy=3DDsBB1w@mail.gmail.com/
>

Thanks for the patch, that's really helpful to catch the kmemleak issue.

Reviewed-by: Yi Zhang <yi.zhang@redhat.com>


> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  check | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/check b/check
> index 6d77d8e..3a6e837 100755
> --- a/check
> +++ b/check
> @@ -183,6 +183,36 @@ _check_dmesg() {
>         fi
>  }
>
> +_setup_kmemleak() {
> +       local f=3D"/sys/kernel/debug/kmemleak"
> +
> +       if [[ ! -e $f || ! -r $f ]]; then
> +               return 0
> +       fi
> +
> +       echo clear > "$f"
> +}
> +
> +_check_kmemleak() {
> +       local kmemleak
> +       local f=3D"/sys/kernel/debug/kmemleak"
> +
> +       if [[ ! -e $f || ! -r $f ]]; then
> +               return 0
> +       fi
> +
> +       echo scan > "$f"
> +       sleep 1
> +       kmemleak=3D$(cat "$f")
> +
> +       if [[ -z $kmemleak ]]; then
> +               return 0
> +       fi
> +
> +       printf '%s\n' "$kmemleak" > "${seqres}.kmemleak"
> +       return 1
> +}
> +
>  _read_last_test_run() {
>         local seqres=3D"${RESULTS_DIR}/${TEST_NAME}"
>
> @@ -377,6 +407,8 @@ _call_test() {
>         if [[ -v SKIP_REASONS ]]; then
>                 TEST_RUN["status"]=3D"not run"
>         else
> +               _setup_kmemleak
> +
>                 if [[ -w /dev/kmsg ]]; then
>                         local dmesg_marker=3D"run blktests $TEST_NAME at =
${TEST_RUN["date"]}"
>                         echo "$dmesg_marker" >> /dev/kmsg
> @@ -414,6 +446,9 @@ _call_test() {
>                 elif ! _check_dmesg "$dmesg_marker"; then
>                         TEST_RUN["status"]=3Dfail
>                         TEST_RUN["reason"]=3Ddmesg
> +               elif ! _check_kmemleak; then
> +                       TEST_RUN["status"]=3Dfail
> +                       TEST_RUN["reason"]=3Dkmemleak
>                 else
>                         TEST_RUN["status"]=3Dpass
>                 fi
> @@ -451,6 +486,18 @@ _call_test() {
>                                 print \"    \" \$0
>                         }" "${seqres}.dmesg"
>                         ;;
> +               kmemleak)
> +                       echo "    kmemleak detected:"
> +                        awk "
> +                        {
> +                                if (NR > 10) {
> +                                        print \"    ...\"
> +                                        print \"    (See '${seqres}.kmem=
leak' for the entire message)\"
> +                                        exit
> +                                }
> +                                print \"    \" \$0
> +                        }" "${seqres}.kmemleak"
> +                        ;;
>                 esac
>                 return 1
>         else
> --
> 2.52.0
>


--
Best Regards,
  Yi Zhang

