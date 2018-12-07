Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C15CC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 04:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BEC2064D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 04:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JhDQ7F5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BEC2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGEDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:03:44 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:37428 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGEDo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 23:03:44 -0500
Received: by mail-lj1-f176.google.com with SMTP id e5-v6so2374346lja.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 20:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRMdxz0/jdAtEh+ysTMfzxhApoYpJo47caFDN4H8soc=;
        b=JhDQ7F5hzND4qIibMuzQo8guzht0+aUALWqvXvEmKCAiuA80x0UYroTvskj3WdDyje
         wL/xpzQsXVJgP7Vsu7dIEiSpU3zXZF6IH4Nto3F0U0YNbctioRAH8E4hFb2n9yDf+Mj2
         YC1i2S3MkpJWcy4XbtC+u0EMBN5CmZaBOZCuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRMdxz0/jdAtEh+ysTMfzxhApoYpJo47caFDN4H8soc=;
        b=b6QgevNwFDxSIRkexnUm8QfJBPr+s+iKqlPAo4D2c2IWXZ4cSLqfLG2FSM1Btiumf4
         V4U0o8W8O+jO6fl1wo9Hk0Kp5WhwFCC+LOOl/LJFM1tSEOcSvbieGoQlSeVsrfZz+bWP
         ojf7hInz8TfqgAcx56l+vt+Iak9ryrJnx34ZsTYoPsAjlze2mxf/01b0gXhfpOE5qHxB
         UlCUe/fOlHZOGOXbzNNoCCGtI/Xb/oTiGMj6fkIS8CjIL4eOFUNNHJ+g8VCDtHOnbp9l
         GUwLbqUibG0IOWpulkInpozDAps0FVzbX4McDr2UQiY65QNk2y9xe+8vYs4OebgsE7Rr
         D3SA==
X-Gm-Message-State: AA+aEWY5yvH8LAx+Epn+q5tkmV8I/RQxK0dgu20wwPY9YLMmOw2Byb/Y
        g+gmZO7EURroCvQuHNs6VDRA93n9O8o=
X-Google-Smtp-Source: AFSGD/U21vgr9JKr2Dkk6Te9j9/6DQorVZci5rpdkmSVSkQ+VIqn5ptcIGEsqNAZ+GZE3p6j/Mgsew==
X-Received: by 2002:a2e:99d7:: with SMTP id l23-v6mr288147ljj.165.1544155420885;
        Thu, 06 Dec 2018 20:03:40 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t144sm388142lff.53.2018.12.06.20.03.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 20:03:39 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id k19-v6so2327139lji.11
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 20:03:39 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr329598ljs.118.1544155419174;
 Thu, 06 Dec 2018 20:03:39 -0800 (PST)
MIME-Version: 1.0
References: <fd37a010-d44e-dab7-4e39-059a339091eb@kernel.dk>
 <1544142034.185366.293.camel@acm.org> <ee93d591-3476-dff1-590a-6ea74efd8f8b@kernel.dk>
 <1544142690.185366.296.camel@acm.org> <6f48f48f-10c0-07db-4e90-b310c87554b6@kernel.dk>
 <11e4cade-3c46-8537-dc92-b7bf510f1fd7@kernel.dk>
In-Reply-To: <11e4cade-3c46-8537-dc92-b7bf510f1fd7@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Dec 2018 20:03:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3+Yh-2+o26WWj5vVFg9Qb9RPnuYOJwatKHCHd1AW=+A@mail.gmail.com>
Message-ID: <CAHk-=wi3+Yh-2+o26WWj5vVFg9Qb9RPnuYOJwatKHCHd1AW=+A@mail.gmail.com>
Subject: Re: [GIT PULL] Follow up block fix
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003fb2f9057c66b3cd"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000003fb2f9057c66b3cd
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 6, 2018 at 6:12 PM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> Linus, I just know notice you are not on the CC for the discussion about
> the patch. Don't pull this one yet. It'll solve the issue, but it'll also
> mess up the BUSY feedback loop that DM relies on for good merging of
> sequential IO. Testing a new patch now, will push it to you when folks
> are happy and when my testing has completed.

Ok, this pull request dropped from my queue.

                   Linus

--0000000000003fb2f9057c66b3cd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIT/AYJKoZIhvcNAQcCoIIT7TCCE+kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghEQMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0BAQwFADCBhTELMAkG
A1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEa
MBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNh
dGlvbiBBdXRob3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7
rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq
9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI03BO
rNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqck39UIm/nKbpDSZ0J
sMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMBAAGjggE8MIIBODAfBgNVHSMEGDAW
gBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNVHQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYD
VR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1Ud
HwRFMEMwQaA/oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5j
b21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf2
8/ZJCAbU2C81zd9A/tNx4+jsQgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/h
k6zSPwIal9v5IkDcZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMp
IMwpWZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNmNppI4ZNM
UH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade2022O/tUU1gb4jfWCcyv
B8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZojTq/OCR6MvnzS6X72HP0PRL
RTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz
/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1
niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxhcsjy
cBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggXYMIIDwKADAgECAhBMqvnK22Nv
4B/3TthbA4adMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRl
ZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xMDAxMTkw
MDAwMDBaFw0zODAxMTgyMzU5NTlaMIGFMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBN
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
AaOCAfMwggHvMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBRjn/GS
Juh8DKxLx8YgPKopKgyxBTAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAX
BggrBgEFBQcDBAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYM
KwYBBAGyMQECAQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BT
MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYsGCCsGAQUFBwEBBH8wfTBVBggr
BgEFBQcwAoZJaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGlj
YXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2Rv
Y2EuY29tMCgGA1UdEQQhMB+BHXRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnMA0GCSqGSIb3
DQEBCwUAA4IBAQAGi1sxlNUFKWBzuBr+awa5Pl46M0AHRkFPiu3VKUkaNu8XuIA2i6Pj6rgiT/3l
7ca/KvxohOUvFTYnq6Fr26H6BJT6XaMiC6LItbfoIMB2yzFOVuruxfTUO7TCJPCg4oLEtUUIMS1v
KrajMYuEaI5rVAY04ntAa9nRnjj8TqDg+OXupr8yHrkomt7qWlsyZQKExtmQ4DvfEUADDY2ue6Kn
qNa5FHY8uBWlYBSaHnnR90Rr0Rqd4naFPQ1Kkkxp35g0tcdGBN5Qcyli834X9rdyhj9CwSwOSnCD
KYvaXyUP3o7hBubLcdMz/VM9VKT5HnU6c3rFemJSmUc41Htu57YYMYICsDCCAqwCAQEwga0wgZcx
CzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZv
cmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAyRamH6VuTQrvgXSXzzbh6jAN
BglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgygE7iqgnWBY/RMkC6QgGYUNg57hSY5mp
vfipZt+X1NYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMjA3
MDQwMzM5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIB
MA0GCSqGSIb3DQEBAQUABIIBAFbk/p26MF6yxGAmal/V23uNps0snD4oUJbEytksNyEcweMnMqUQ
oBVQF141rE5Kqvsnag8HTkvmm/V6Za5zu0SJ2TgaxQ88wBEQpFV5NB4kjnrZN3dZj5PB3M3xq67F
6DLpsL4oWcGbm7dFQIr+kBfvtzdMRWUUM0Y+32HohigH+D7mweoGBDIqn4Vzb44994d6unkHX5wJ
ftXLn0U8R5CrW/IjweK2w39LsLlS1AHEKEeerZdHsOd8FFqiNr9p2p4atzk9hARdF4MM2TmKgfD5
WyJV5LDoZXNfZNBXyaksZKzvr9Nuxfu8JnNVSVDe4CYYTaem0UmASbjQOO1nLa0=
--0000000000003fb2f9057c66b3cd--
