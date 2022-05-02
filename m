Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C762C433EF
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 20:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387394AbiEBUcC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382969AbiEBUcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 16:32:02 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A98A193
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 13:28:32 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id k2so5553703qtp.1
        for <linux-block@vger.kernel.org>; Mon, 02 May 2022 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MigS+tMN72qhpmZoSjthskApsxxhw1PEtab4A7G0Sc=;
        b=GnUlWmoTI4s9l4fAdCeHx7X2E2lZIvDTBax/K+rkCZzwZCvWu3DunkXOALmb9sYfZF
         HsXHYP+WI0V32fxswJxzV1bpUkwWcIUVBWcrFYtBAYv/Nb9qGuFIWZTOE026tPLGbOzx
         ecXkRG8eUN1tY0KE4SZ5tfZ7nLGqrCDmRVwrlJsht6dCkQjVRYirkBYQI2Ry48Xgr+wo
         hhJ3MDH40rSjLoc8zt8WNLL8oFOJczucfP6sVm8FuN49S58cpW3KGcn9ZhMBbkA7RhBM
         KRk6D+lTu84LxCQMyDyoYWggmGQs4svFyzm2bbBmsw9bkrXFhYAAFfbt/2DrESuiO7lt
         n7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MigS+tMN72qhpmZoSjthskApsxxhw1PEtab4A7G0Sc=;
        b=DGHyWtAm7orcsRi75U57rAf0DA5Dip/BU40qfXVGQXCT6X+niy/TbUzMgtuerkPJTj
         mbDx3rYgIRLYGPdRGA6MiOeytjqcqWoLtflsIS54zubIv6SujF1zSFhmjyOU5Ye8+4XI
         blqaL0tZbbuhijuGsxt9OC5K07rymmKprWqX3ik332Gz1X99bTOzROsRt2A0RL6y+0Il
         MV4EMTmrra98anUXv5nn3w85UhU2fd6bhSB2LiQ+fM/GNwK6nRUkoeZgxbCHpNJrmRI0
         AXNqzIw7UF0igH13zRUgfN1NgvWZlYKC4t1HOSQ9xVZAm9acaGKl3Q95zZaO7BIx660R
         bodw==
X-Gm-Message-State: AOAM530V3M3gCqw4rtWoPz0zfu223xEv5fg42ciBvhsmspO+ncPq72s3
        qUbKlIqUGvEeWvamxbgNdG0v/9F4jnH2Wyd1tICAhA==
X-Google-Smtp-Source: ABdhPJzEvXyvMI61NMlzJ9upIwoyeX2XxZNK2Z1AYb0u2nk9ZiQlAnnV4fZD9pJ43o5lDRGKQc5nePT2TMm+KJfX9sI=
X-Received: by 2002:a05:622a:1012:b0:2e1:e7f3:5c89 with SMTP id
 d18-20020a05622a101200b002e1e7f35c89mr11921209qte.550.1651523311321; Mon, 02
 May 2022 13:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de> <87y1zjq14c.fsf@collabora.com>
 <yq1h767epmx.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1h767epmx.fsf@ca-mkp.ca.oracle.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Mon, 2 May 2022 13:28:20 -0700
Message-ID: <CACGdZY+=Ugn0vd4+zsFoKwHp6f3Rv27wdssgvSoS_Onoi1yXUw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] eBFP for block devices
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Hannes Reinecke <hare@suse.de>, Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000055fd9605de0d3c59"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--00000000000055fd9605de0d3c59
Content-Type: text/plain; charset="UTF-8"

On Mon, May 2, 2022 at 11:53 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Gabriel,
>
> > Cc'ing Khazhy since Google might have some applications for this to
> > filter IOs based on the blocks being accessed, in the context of
> > safeguarding specific regions from accidental overwrites / application
> > error.
Yeah, we have a few potential use cases for something like this - one
is interested in filtering based on issuing user. A separate use case
would be filtering based on regions - for this I do wonder how
appropriate something like eBPF would be, especially if we wanted the
filters to have some guarantees of existing so long as the data we're
protecting exists.
>
> We've been working in this area too. It possible to write BPF filters to
> protect block ranges using should_fail_bio().

It'd be nice to have a "proper" api vs. ALLOW_ERROR_INJECTION, which
feels more debug-y and has the drawback of
CONFIG_FUNCTION_ERROR_INJECTION being all-or-nothing

--00000000000055fd9605de0d3c59
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
h3dPtFviTyG11HYwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAE0ANr7NUOqEcZce4KYP
SjzlrshSC8sgJ8dKDDbe35PL86vDuMIrytVjiV10p/YUofun9GeHBY6r5kTyh4be5FgftiiNtWzn
U1W5cxLYMT1hKYxXxnM2sWMQGFl4TkxxbRoVZa3ou/NxFdAZeiQSwGnzk5oIDTBZQc8q3wMa1svm
A5Rd4MVaIUt+hyk6seAldN6k4/O34O1l2V6D+/BwagyzLWvOeMEM9hClVF+F6a20yy4dcDsprFZZ
Sk9JzUy9F6FM7L1wT2ndjTNDja4Y2tixf31KuisZLGKmDZsW/fXF1GgWDaM0DbYJwtE3kHylWnMk
CN4PfYgIa15C5A9lXhExggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAFEftjde/YEIFcjUXqhcBUwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIE5XB25r
ggMWfo+7ejZO7s7Qpe1YagLrghnpSMCEzHyvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMDUwMjIwMjgzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBgq0vHJLLXHT6uzXFr+Jw837eV
5who3bI1RbRZVhVGPc9PQIFp42ZiJB/SMip3oGubqDmPkEdxY41zXjiZwJ5TeNYjxno9QQlRhtMF
ybOMjUgesmNVfunfhEOC5VzJfIlsMFpLtIwEv3BkJgm8BaQ7tqAgmpo4oh1mNHWE1903h2YT1zdH
a1hTfQ/gnHwr1s4a1TLnvXbw/20BuWdS/J8K1yvbUfVAClKWdiUGZEe77bkTSnl4Gl0AORdVL3kG
0lwmIOiRrcbv7KAanAC+IAilIIm9gvNincZ/pLFKLEufefm0bL+KCH6WLdh2qAZvWrs0TZKHLwD4
+sBaVQ5LjQDt
--00000000000055fd9605de0d3c59--
