Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3531CC11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A3761480
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhGAI0N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 04:26:13 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.111.105]:27916 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234865AbhGAI0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 04:26:12 -0400
X-Greylist: delayed 87241 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2021 04:26:12 EDT
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2052.outbound.protection.outlook.com [104.47.20.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-5cliSTwON2uP36UqBFayWA-1; Thu, 01 Jul 2021 10:23:40 +0200
X-MC-Unique: 5cliSTwON2uP36UqBFayWA-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB2951.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Thu, 1 Jul
 2021 08:23:39 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 08:23:39 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: prevent sending events from removed device
Thread-Topic: [PATCH] block: prevent sending events from removed device
Thread-Index: AQHXbYcPaY+gyAaNCEO3EseEwW+vDqstvh0AgAALZm0=
Date:   Thu, 1 Jul 2021 08:23:39 +0000
Message-ID: <CWXP265MB2680A529C732A3137C15991DC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680EBAF4FEE64FBE80FAF25C4019@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<YN1xzGPbx8ac8r3j@infradead.org>
In-Reply-To: <YN1xzGPbx8ac8r3j@infradead.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2605fd0-b342-405d-9850-08d93c6987a3
x-ms-traffictypediagnostic: CWXP265MB2951:
x-microsoft-antispam-prvs: <CWXP265MB2951A88EF3A5503D936AE1A7C4009@CWXP265MB2951.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2582
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: o4EjCEJ38YhwbrVOJvCplJA6ZxzlykVhGmjNhxMZd2aa8QsWGT0LVv4Ali50abMWbti0W28x95lN7NvQk0pA7LWsjdJcjQymLI2Um7c1YjPexNqj0XQhx5s/Mfg5QJC+FBkHCaI6QQzX10tAzuuwfAiJRZRucqowE2AMJS7N2I4G/iuVftSuFtJhVN3GkwOWW2nmCAWHSRvkDINM7nIcNYOGYwOl3AEGg4WSKC6WmlcAlGPCSjm5BlbFqFJaRzPYrmdGkjjgR8wHtoWrtStMZZrFsekGfxv7xJPTo6TYlKLKmWPHSP5wg/0azg4uvMSLbBGynuFCxWzu9AG99kassQCshWYyezknNkQ53Uk6JSR5lqkf2OYXszaueJv6IPldDrfn0C0UcKvK/FYTtZHs/e0633ioCuAD5472o4W5vAU8fMaTzQjO7XLHYoEcLIggEl5tUXv507Y+x6GPnXRH1XRNU3RAefP+HviJ+lQq0tdMFdQje23hzT2wqjdIBE3O0XX2U1efCdgjTuMVbmASCvtfmFOl/1FDlkKXDxhnbe0aI93eDinpcVk7z3//Viu0hpDoZpC82PJDRFwZ2C75jsh9sYZz47vhqZW5fJ65IS7XlLyjHLNhrBgJbQERA3+LVcq/DmxyK5x7gcpVSVVtvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(396003)(39830400003)(2906002)(71200400001)(316002)(33656002)(54906003)(6916009)(86362001)(83380400001)(122000001)(38100700002)(8676002)(8936002)(52536014)(5660300002)(6506007)(7696005)(26005)(9686003)(186003)(55016002)(478600001)(4326008)(64756008)(66556008)(66446008)(66476007)(66946007)(76116006)(91956017);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hvkAaEto4cT3r7fZt/CcbaIeE6X7azmuN+3UtL5xrP+LrXHVUt7Wd4HO9Q?=
 =?iso-8859-1?Q?yPDSS8HM55GY7wkps85w1PblBK9OCPxckUmneO2HtE6NfQKkvpKjpzmnH/?=
 =?iso-8859-1?Q?wNk9f2EyNp7o/SdSnOLfxFBYPqn5M5haKGT+2b1SNM7JttFPMkX2Kq0SMt?=
 =?iso-8859-1?Q?Oq60zefE7hnqg3Au7Mf7KatEJfDVoUZ0q3NGcxzgmfMqOP3+zqxrJJpBQo?=
 =?iso-8859-1?Q?H4FumkR02wJw2pnNGETLG1BkbbBBPIWYYzcZphWpO9qxpHRToosNKFYEO3?=
 =?iso-8859-1?Q?O4UMLgSaJqFRo3hYgA/uTXWGm1IeVkNkyjAH7aZEeertTNoL3s16c5pKSF?=
 =?iso-8859-1?Q?qayAFqz0+R5h/pAPaSAWkeJMVBQN6D2WNMn4CS9/moW5fA+XsrllZaeHxN?=
 =?iso-8859-1?Q?Eo4xloGLgNL4AuWDOby4yX1j8cP/n1cE0CcxievbUZIwBBKKcIVHXwLtvt?=
 =?iso-8859-1?Q?yx2kmLNn1NDk5cUZlnu3suHfTdWCv1QVV4uS0rF+Y+dUncMNd9TLqOLtVq?=
 =?iso-8859-1?Q?MmZ2rEm2UUSlnZetNMsKOZSSfZKaLcBCEc201uQaylZy2H+KGM1/xQQwy7?=
 =?iso-8859-1?Q?/TMt7SitSSsPStRcVkd8GYI41Fho8z0naWcFo+04qQCuGO06uKwemNnoRE?=
 =?iso-8859-1?Q?IbyNg0L2Pu2mmyuDA7SaKY2AiUx3U0U1aKf1nHjX3EjEDP8KVgZtEZliH3?=
 =?iso-8859-1?Q?VtQJjFGgeaa1nEqO84QyXSOJHEL/05hbIRJ0EGBjBIWlmJjqqXmhUBNPuE?=
 =?iso-8859-1?Q?nfhZKL2TqxsMmrtnyAXzeKrNf10uB06wnj4cmraaSbdoZ2KMom6Rn4ohgc?=
 =?iso-8859-1?Q?4r2qT9RpF5wBY07UEW67Rk0iwgy1Ht/e8QwYveI17++fgofMdZW9GaEY5H?=
 =?iso-8859-1?Q?qR57m5fTSVvymFDG8dxstUELQnwplchBngiWfyulhyYcWA/J747nkJj6QG?=
 =?iso-8859-1?Q?FlO6uXJOZzz0n57f2rDqHhkJFaeRXSX2j7IQvAJLU7l3xEMf+Nuzc+InIK?=
 =?iso-8859-1?Q?E1fnb9SGTQhX6a5wO4eU+quHVTNTY1azRV/sB4XagY61TdNY3+uPptjG4s?=
 =?iso-8859-1?Q?nfkPt4biIbKD8QmbaOG3bIXNJXJPeaZaO/+J6uoDtnx8uZbRkqaXEapJLK?=
 =?iso-8859-1?Q?R6VnqiQmKdoIjy+Glx7gzipJdMnsH8Cv9Q38FqvBKqnZl5zfJEQuca0kGu?=
 =?iso-8859-1?Q?zzEJdpi0koAZNk5VYQ/hq2v8KUWlotG3r/3TFoUji0qyeoyGlqesQeulp2?=
 =?iso-8859-1?Q?IVCJK+c77bmzbK+/Min1NhyxPqnIaJCEtmMymwALgAG3racHrLG0Jy3nJ5?=
 =?iso-8859-1?Q?p6Jjt39FYMUScvQxtEIQbfiIkzP8k19BlJBtobaztYot/GM=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2605fd0-b342-405d-9850-08d93c6987a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 08:23:39.3100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gS4roEZ/wLZ98r3m4qDQ1QN73ozF6N9nk0K6M5O2mJ5vbaMOeqe7YPy5HJ6DLj9Jl9uJ2m3eI265cSEpZWvaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2951
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Alright Thanks, I will try out your suggestion and report back.
Regards,
Christian

>I don't see how this is going to work.  If the device is being
>deleted the reference count will be zero and refcount_inc as
>called from kobject_get will WARN.  We'll need to check the
>disk is marked up, and we need to do that under a lock.
>
>Something like this completely untested patch:

diff --git a/block/disk-events.c b/block/disk-events.c
index a75931ff5da4..27b845c51f2a 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -190,6 +190,9 @@ static void disk_check_events(struct disk_events *ev,
 
         spin_unlock_irq(&ev->lock);
 
+       if (!(disk->flags & GENHD_FL_UP))
+               return;
+
         /*
          * Tell userland about new events.  Only the events listed in
          * @disk->events are reported, and only if DISK_EVENT_FLAG_UEVENT
@@ -268,6 +271,8 @@ bool bdev_check_media_change(struct block_device *bdev)
 {
         unsigned int events;
 
+       lockdep_assert_held(&bdev->bd_disk->open_mutex);
+
         events = disk_clear_events(bdev->bd_disk, DISK_EVENT_MEDIA_CHANGE |
                                    DISK_EVENT_EJECT_REQUEST);
         if (!(events & DISK_EVENT_MEDIA_CHANGE))
@@ -290,7 +295,10 @@ static void disk_events_workfn(struct work_struct *work)
         struct delayed_work *dwork = to_delayed_work(work);
         struct disk_events *ev = container_of(dwork, struct disk_events, dwork);
 
-       disk_check_events(ev, &ev->clearing);
+       mutex_lock(&ev->disk->open_mutex);
+       if (ev->disk->flags & GENHD_FL_UP)
+               disk_check_events(ev, &ev->clearing);
+       mutex_unlock(&ev->disk->open_mutex);
 }
 
 /*
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a093644ac39f..b8e77da44235 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1735,8 +1735,10 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
                 /* invalidate the buffer track to force a reread */
                 BufferDrive = -1;
                 set_bit(drive, &fake_change);
+               mutex_lock(&bdev->bd_disk->open_mutex);
                 if (bdev_check_media_change(bdev))
                         floppy_revalidate(bdev->bd_disk);
+               mutex_unlock(&bdev->bd_disk->open_mutex);
                 return 0;
         default:
                 return -EINVAL;
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 87460e0e5c72..2a97f22cfa0b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3185,8 +3185,10 @@ static int invalidate_drive(struct block_device *bdev)
         /* invalidate the buffer track to force a reread */
         set_bit((long)bdev->bd_disk->private_data, &fake_change);
         process_fd_request();
+       mutex_lock(&bdev->bd_disk->open_mutex);
         if (bdev_check_media_change(bdev))
                 floppy_revalidate(bdev->bd_disk);
+       mutex_unlock(&bdev->bd_disk->open_mutex);
         return 0;
 }
 

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

