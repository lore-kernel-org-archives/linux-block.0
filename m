Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9E5C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 21:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358109AbiFNVsA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354808AbiFNVr4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 17:47:56 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCB82F018
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 14:47:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id k18so7097498qtm.9
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8Yes5BtIknDbY6hXw+TV8wJywc42VHoteAitNsNTsY=;
        b=i9nCymApVDYA8GZffZ1lwnF1mx2rS1S8zPAP0mesAUF8qYaiM5H1Ax9aRSiaxxjqXH
         l7maMWMqYZJjPoKXt8mnF9dNj/cdnejFVIIKZ+wuPlMA4C7se2Nu8prPsIdTwsUHC1Vw
         9CPD+qItcFJFgyLcSCHwPwB2YS9+/EcNvvH8DIcxPSi4D7t0uISTIielD2Amzh6HHdoX
         2S8JQLzWw0Ozfz2kasVhaGVGV9rQrvqy9gjebNX5Tq94NxCUI8Q1gnNUc6KSOGF4DRI2
         TD7U3zWtrT5j+zbhSXeRnvMGvu7dCqNmCBtTeOYf1XqBRtFjFTmgSEL7fQs/H8Pc2WBp
         InHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8Yes5BtIknDbY6hXw+TV8wJywc42VHoteAitNsNTsY=;
        b=1dqATE4tIlD/G9uyZtV9gMkQPncn9eyIi4vDNbEN0LIjzXuNqbscEg9CVQM0vmRDcn
         63c57muBGUm9NzRGaFIMX4bxHlAQaKOWylpPKOw6i1F8NkeG9g35J1zBXnoMd+uXYE22
         uD05DgVhJUkNmEPdzbA78ZEsMC2CZObdEKCubEU9A6USCO8CfBPyaT9qBvZw4KkIS/Jr
         XCzyLY1371zcHSNR6IbAcXb/uT5JHwbVQ/FVzLSnaPeG18gQCHsU/WPMNo89bmCnDwZO
         4Ef0zwgQl5pz5HSyUHbX5ZNJ/GZNgxVpxfPqEBJkdtlAzJCZOAh5MmPBjr81Dc7u7Q3Z
         cHWQ==
X-Gm-Message-State: AOAM533JlXTVOVmZUnzzz8nM9pMQUXTHvT74KcVSXOCJ5In5q753ETuD
        HhHwRH2mR13RJh9+vg7MmRSvLcSZJkV8vTv5gBM8QA==
X-Google-Smtp-Source: ABdhPJy6Lx5b08HBvbMCWchEucCRoclsdsBcU4VepgKf5fugOn9dg8v9tDBLszYTaQ97gdyy60zJsdZESZYDqFeenCk=
X-Received: by 2002:a05:622a:11c8:b0:305:9a3:240a with SMTP id
 n8-20020a05622a11c800b0030509a3240amr6274604qtk.306.1655243273489; Tue, 14
 Jun 2022 14:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220614174943.611369-1-bvanassche@acm.org> <20220614174943.611369-3-bvanassche@acm.org>
In-Reply-To: <20220614174943.611369-3-bvanassche@acm.org>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Tue, 14 Jun 2022 14:47:41 -0700
Message-ID: <CACGdZYJ7HfykzbgiPpT7Ymd0h39qQE3qfz90QCNeoBjK04-HSw@mail.gmail.com>
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005df76f05e16f5b4c"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000005df76f05e16f5b4c
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 14, 2022 at 10:49 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> From ZBC-2: "The device server terminates with CHECK CONDITION status, with
> the sense key set to ILLEGAL REQUEST, and the additional sense code set to
> UNALIGNED WRITE COMMAND a write command, other than an entire medium write
> same command, that specifies: a) the starting LBA in a sequential write
> required zone set to a value that is not equal to the write pointer for that
> sequential write required zone; or b) an ending LBA that is not equal to the
> last logical block within a physical block (see SBC-5)."
>
> I am not aware of any other conditions that may trigger the UNALIGNED
> WRITE COMMAND response.
>
> Retry unaligned writes in preparation of removing zone locking.
Is /just/ retrying effective here? A series of writes to the same zone
would all need to be sent in order - in the worst case (requests
somehow ordered in reverse order) this becomes quadratic as only 1
request "succeeds" out of the N outstanding requests, with the rest
all needing to retry. (Imagine a user writes an entire "zone" - which
could be split into hundreds of requests).

Block layer / schedulers are free to do this reordering, which I
understand does happen whenever we need to requeue - and would result
in a retry of all writes after the first re-ordered request. (side
note: fwiw "requests somehow in reverse order" can happen - bfq
inherited cfq's odd behavior of sometimes issuing sequential IO in
reverse order due to back_seek, e.g.)

>
> Increase the number of retries for write commands sent to a sequential
> zone to the maximum number of outstanding commands.
>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/scsi_error.c | 6 ++++++
>  drivers/scsi/sd.c         | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 49ef864df581..8e22d4ba22a3 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -674,6 +674,12 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
>                 fallthrough;
>
>         case ILLEGAL_REQUEST:
> +               /*
> +                * Unaligned write command. Retry immediately to handle
> +                * out-of-order zoned writes.
> +                */
> +               if (sshdr.asc == 0x21 && sshdr.ascq == 0x04)
> +                       return NEEDS_RETRY;
>                 if (sshdr.asc == 0x20 || /* Invalid command operation code */
>                     sshdr.asc == 0x21 || /* Logical block address out of range */
>                     sshdr.asc == 0x22 || /* Invalid function */
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a1a2ac09066f..8d68bd20723e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1202,6 +1202,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>         cmd->transfersize = sdp->sector_size;
>         cmd->underflow = nr_blocks << 9;
>         cmd->allowed = sdkp->max_retries;
> +       if (blk_rq_is_seq_write(rq))
> +               cmd->allowed += rq->q->nr_hw_queues * rq->q->nr_requests;
>         cmd->sdb.length = nr_blocks * sdp->sector_size;
>
>         SCSI_LOG_HLQUEUE(1,

--0000000000005df76f05e16f5b4c
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
EAFEftjde/YEIFcjUXqhcBUwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHDJz3BO
zw3uh+55YBbD4vuD7Eslt6+jAkhhCv4385TMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMDYxNDIxNDc1NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAZeNnFdmr6YEJ/3jnzW8foJhOf
trdcRSJQEknMP8V9sNgOQdgm6ZcwR0NtgtQeeC8i/m8DiRqf0Jfje4BO0I4j/VhWvi0V0bVKOP5v
IpNhYfyWhTdrJdowZKol88L3xkT9SBE7cJ9+T/LOEQjX8bqMzhJXojXDqEJOxxtneLrCaOH6XiXu
tQkfamk2l0LiMsjinMs+1hAiSVjt9AJfdLRlx0+sJrLKxHzdrLph09UlPMC/z942zg0K/As/a43N
tCusoWBcFK2qLmYIJu704RI1el8c6t6n37b5Qh4SnHhRxlOzbl3Iqlgd13s9Hih5NCgwb7msHdwo
vSJbbmiiQA2c
--0000000000005df76f05e16f5b4c--
