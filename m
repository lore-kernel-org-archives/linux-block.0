Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAA7C282CA
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1A121920
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 16:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZSNoMvfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfBMQE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:04:59 -0500
Received: from mail-eopbgr770137.outbound.protection.outlook.com ([40.107.77.137]:6064
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729649AbfBMQE7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 11:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxQYtt+a5tQLOAkkBbxI0ESWa6d1SbJYJy7VzXkDYhE=;
 b=ZSNoMvfiUnc7PoVQ8OjJRJ6gn+pw3o1/1AJSfzck1iamQ4fzHd5+IcQXn4/6afQdNh5DNRA1DZXRJAFloIIxpUttpMn2cL4Aft2KJlPwGVzS3UHkt1KMLmZXCJqpLz50oCtb3izMMocTf5HK4jw4vkElDA9NbVu5nMlhHzr2Ws8=
Received: from SN2PR01CA0032.prod.exchangelabs.com (2603:10b6:804:2::42) by
 DM6PR01MB4492.prod.exchangelabs.com (2603:10b6:5:78::27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 16:04:16 +0000
Received: from CO1NAM03FT052.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by SN2PR01CA0032.outlook.office365.com
 (2603:10b6:804:2::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Wed, 13 Feb 2019 16:04:16 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT052.mail.protection.outlook.com (10.152.81.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 13 Feb 2019 16:04:15 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1DG48CA001078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Feb 2019 11:04:13 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1BFF57A4EA7; Wed, 13 Feb 2019 11:04:08 -0500 (EST)
Date:   Wed, 13 Feb 2019 11:04:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bob Liu <bob.liu@oracle.com>
CC:     <linux-block@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <shirley.ma@oracle.com>, <allison.henderson@oracle.com>,
        <david@fromorbit.com>, <darrick.wong@oracle.com>,
        <hch@infradead.org>, <adilger@dilger.ca>
Subject: Re: [RFC PATCH v2 1/9] block: add nr_mirrors to request_queue
Message-ID: <20190213160408.GW23000@mit.edu>
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190213095044.29628-2-bob.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190213095044.29628-2-bob.liu@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(199004)(189003)(229853002)(103686004)(16586007)(58126008)(54906003)(97756001)(316002)(36906005)(786003)(47776003)(2906002)(6246003)(46406003)(6266002)(42186006)(106002)(76176011)(4744005)(50466002)(26826003)(1076003)(478600001)(36756003)(8936002)(305945005)(356004)(246002)(52956003)(8676002)(4326008)(2616005)(476003)(126002)(11346002)(446003)(6916009)(106466001)(23726003)(217873002)(75432002)(86362001)(26005)(33656002)(88552002)(186003)(90966002)(336012)(7416002)(486006)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB4492;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT052;1:JbCG0SnhWDxKUVdJwxdK9BdovhRq2pazrQVOASQz0GkfPGcvWv04UL27ez7WesaAorswyEL0oFRkOqC1YAEziwZhQx1wHF4gpfboS5QyT3lDqxRwuOYUOkpUeX241tlyMpoLSL0YgcTPYZYR0XmkcQ==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89108b28-c9d4-4a2e-c997-08d691cce74d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR01MB4492;
X-MS-TrafficTypeDiagnostic: DM6PR01MB4492:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4492;20:aWn5HpZFHbrc6cIbkvcD6r3DViGc9jwJi1ZSkWf+/l9sYivvBJNXl1eR/CONBpUoRrQTn4Fe87vrRCljO2rA29aU/kUYy4jOFI4gIHv+IIO6DiajE4I/DQlCCPdeOKVMrCMtuIcGj+TM2OsY2P+Tf0oj5V+rBauIs2XsoS4uhi7kRNv7HGudkN+BZdd8Gomy5sskhIljG2zNhf7Uusp0w8FZzjAkqmQw1adwzPEW7a3FW63RGZlTz7AFO5CI7MUoH/X1z+amB0taFLjxlFIt6GnKWR+fl3T1tKC6VmKUEVqffl3lEpBk+15EMYIk447OYkOPIDJvE33GYDT9Yt4W4gJWSQSvCm3t6YRqwgIKfGmjLvT7LmuQDS51IO9ngFkuHfSlabccOKh/IK9kbOGT51ystt0lr2DBsbqm7W/KLeutrlBzLe3y7RSm6BkwfO81yKgp9ElD8oVwShSXh0wXQBYEjYYatTbJf9zhPxbxKad6g+Fzshiip8zZHmCbyQLkX0tHbBUAcKbMvg8+uaEjy245u2KL3CV6Ox4NsQ+fAxUEUJ4rh3L8PxfKnb9kf2kTT9eh1ez7if150TuQpYSkblDT/KbNNmuayE5xaCf3358=
X-Microsoft-Antispam-PRVS: <DM6PR01MB4492A31B3250B8A90E55EB9AB5660@DM6PR01MB4492.prod.exchangelabs.com>
X-Forefront-PRVS: 094700CA91
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR01MB4492;23:pU+J/rtChdEFsQ0XT2LltBy4QEco+nUG5XtCeuLQP?=
 =?us-ascii?Q?n3g5+4gp5KF+P+e5qE21o5toRpHHfM9JzhQGINx9PYIotLeUq0Bo7icbniUi?=
 =?us-ascii?Q?yo0R4L93ocOELU1Z/hRkEreQiT8o9yhVYaoBDqLih8Nu8QwBSDenDd7MX4Qk?=
 =?us-ascii?Q?XHVJ1XdR7pFhqPXYVdMGqznQRt20rDeYVJ0eIxIGcZNvYl2c0elvPZlnSuGC?=
 =?us-ascii?Q?pzSKurCiB8/SWzR8C8E9/9ofHGlzILRdDI9pXVSWeECXKWu32GlQhkNUvIPf?=
 =?us-ascii?Q?gi8HPcIzwiUHF8COpm35oboXmgn+PD26be/41aiYsDFqyfQTAJK2w5mgykMG?=
 =?us-ascii?Q?qeAwHg8PWeEbSgyUCzGa2xIyuG0I/G4ZWIuCSQPIsVci0umHdWy0gKipWyN4?=
 =?us-ascii?Q?/20WLH2FfkarwgfdjInh7YxH6gYsLzEqpLa15LVSIuhhj2KlUP9cTtZLvGlg?=
 =?us-ascii?Q?TopyE2gbd5yDWcTzh0QwT4ijfvIOPllMM4Jnb/tX0iFmDvRRe+IaifqzbCsJ?=
 =?us-ascii?Q?0093E3HqcoSV3UfCgutI8fhQWj/93C+zUbDkVIqBpMvPTCi0ShZlWoaB4Ilq?=
 =?us-ascii?Q?0BuMNq3LOcEdTRc2R5Nma3DEf1tzH543hrNggsn3OTyIqLVOVs+0Z2xtVX0U?=
 =?us-ascii?Q?qODtMucdRCC/eOdN/n6V0WzaAqvodm0PRhTYQQoBzaoF/Ls2SobONFadDwaV?=
 =?us-ascii?Q?GWDa8cv0Jyh4fA5PHE+Oae3I76xKa5b7Hhq3WY7e2LcDb9sMojSMJYxD5pRB?=
 =?us-ascii?Q?6m/pJLBrBbZuR+G9LZz05uGo7cP3mZ+0I3DNScfJujzwIYRrUK7oX1LjoupV?=
 =?us-ascii?Q?u4nplrpopT0ySL45iOI1WLuNEfbAVLQXtkRYBSF/sDixzHCZqVCx7kqpPzzm?=
 =?us-ascii?Q?k+MYmh/RTzbX5CNBMVNwMqAwqqhfVq8/NeImIKgUozUBqtN6x24XJDcxQmJn?=
 =?us-ascii?Q?oKPKEHx0jDGSDEhMeZho7OSKFA1GLaE1Htwu9cvN5xInTK+BfKU2XfJHkpXv?=
 =?us-ascii?Q?jgMJ5W/VjmVP5+BMqD10a1HlLUaARDkpHIv98EJAZVVvtVaUobrojbYh/MaL?=
 =?us-ascii?Q?MB9VsdxRQrVedqTq3hEqSHoNXZiXJ+hnHEm4khnkLiXOcEslEv8Hsd3x7+As?=
 =?us-ascii?Q?U3zsz7wZeRsu908dZfYb5W6UuW8OZIL96QgGcl5bUrmBrocaEjU8v29RdQjb?=
 =?us-ascii?Q?taApYaET+TButAgu+ywc1IHqY58zkkFitgSEBXoTS7oupvq5HsvN0mEpB4xY?=
 =?us-ascii?Q?NuBrxpp0LsXtdbTLUzbwfbNgWuEnRBrBAL5ktSEApttTr0N/ELDkaotn7EAW?=
 =?us-ascii?B?dz09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lXFwZ953cE5Wen+2+TshLxStL0kf8zShMD5L4A8qC54fa1Npxd4Ohd5xcBDmpEXZNoLdf07oxHIdeQ1C2KZt5TUATU8n7Im3OArq7e5eg15C7/DwFqoTR0aaF2+PUo3jOmq87KDNLpGx59/6hBlhPharmUjyGwf+uLISFzAKn2QEPzBTo/2sq/N6LjBQ8a+lCoiZ/F1WbPfucPj3TFm7xv+WBVq4wcVD4IAyxhEc/BOGLlnpf594YKLmZmL0KNN9X3IgeWTNTOQ3fAflhoeULkQme4vyDOqrcaf/T3imk+LtdSigyf+eaooF8CD79rrdQKvmAL2jfTuU2CBZwE1GI6xkY4QEK7cWctVI3VmMtx1NeQ+cA/AvGak2GvSjppcX0CRyj0w63lL7Kj/sFKXpp8U8uUn8V4wIdYVhE9sZN8o=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2019 16:04:15.2008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89108b28-c9d4-4a2e-c997-08d691cce74d
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4492
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 05:50:36PM +0800, Bob Liu wrote:
> @nr_mirrors is 1 by default which means only one copy, drivers e.g raid1 are
> responsible for setting the right value. The maximum value is
> BITS_PER_LONG which is 32 or 64. That should be big enough else retry lantency
> may be too high.

This is admittedly bike-shedding, so feel free to ignore, but...

In the case of Raid 6, "mirrors" will be a bit of a misnomer.  Would
"nr_recovery" be better?

Thanks for working on this!!  I would be interested in using this for
ext4 once it's available.

				- Ted
